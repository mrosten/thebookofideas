# Static Site Generator Build Script
param (
    [string]$ContentDir = "$PSScriptRoot/../content",
    [string]$TemplateDir = "$PSScriptRoot/../templates",
    [string]$OutputDir = "$PSScriptRoot/..",
    [string]$SingleFile = "",  # Optional: build only this one file
    [string]$BaseUrl = "https://www.torahbookofideas.com",
    [switch]$Watch,
    [switch]$RebuildSitemap
)

# --- Helper Functions ---

function Convert-MarkdownToHTML {
    param([string]$markdown)
    
    # 1. Protect Frontmatter (remove it for body parsing)
    # Updated Regex to handle optional CR, loose whitespace, and EOF
    if ($markdown -match "(?s)^---\s*`r?`n.*?`r?`n---\s*(`r?`n|$)") {
        $markdown = $markdown -replace "(?s)^---\s*`r?`n.*?`r?`n---\s*(`r?`n|$)", ""
    }

    # 2. Extract and protect <style> and <script> blocks before processing
    $protectedBlocks = @{}
    $blockIndex = 0
    
    # Protect <style>...</style> blocks
    while ($markdown -match "(?s)(<style[^>]*>.*?</style>)") {
        $placeholder = "___PROTECTED_BLOCK_${blockIndex}___"
        $protectedBlocks[$placeholder] = $matches[1]
        $markdown = $markdown -replace [regex]::Escape($matches[1]), $placeholder
        $blockIndex++
    }
    
    # Protect <script>...</script> blocks  
    while ($markdown -match "(?s)(<script[^>]*>.*?</script>)") {
        $placeholder = "___PROTECTED_BLOCK_${blockIndex}___"
        $protectedBlocks[$placeholder] = $matches[1]
        $markdown = $markdown -replace [regex]::Escape($matches[1]), $placeholder
        $blockIndex++
    }

    # 3. Basic Markdown Parsing (Regex-based)
    # NOTE: This is a lightweight parser. For complex needs, we expect Raw HTML in the MD.
    
    # Headers
    $markdown = $markdown -replace '(?m)^### (.*)$', '<h3>$1</h3>'
    $markdown = $markdown -replace '(?m)^## (.*)$', '<h2>$1</h2>'
    $markdown = $markdown -replace '(?m)^# (.*)$', '<h1>$1</h1>'
    
    # Bold/Italic
    $markdown = $markdown -replace '\*\*(.*?)\*\*', '<strong>$1</strong>'
    $markdown = $markdown -replace '\*(.*?)\*', '<em>$1</em>'
    
    # Links [text](url)
    $markdown = $markdown -replace '\[(.*?)\]\((.*?)\)', '<a href="$2">$1</a>'
    
    # Blockquotes
    $markdown = $markdown -replace '(?m)^> (.*)$', '<blockquote>$1</blockquote>'
    
    # Horizontal Rule
    $markdown = $markdown -replace '(?m)^---$', '<hr class="divider">'

    # 4. Paragraph wrapping
    $blocks = $markdown -split "`r?`n`r?`n"
    $htmlOut = ""
    foreach ($block in $blocks) {
        if ([string]::IsNullOrWhiteSpace($block)) { continue }
        
        $block = $block.Trim()
        if ($block -match "^<" -or $block -match "^___PROTECTED_BLOCK_") {
            # Assumed raw HTML block or protected block
            $htmlOut += "$block`n`n"
        }
        else {
            # Text block, wrap in paragraph
            $htmlOut += "<p>$block</p>`n`n"
        }
    }
    
    # 5. Restore protected blocks
    foreach ($placeholder in $protectedBlocks.Keys) {
        $htmlOut = $htmlOut -replace [regex]::Escape($placeholder), $protectedBlocks[$placeholder]
    }
    
    return $htmlOut
}

function Parse-Frontmatter {
    param([string]$content)
    $meta = @{}
    if ($content -match "^---\s*`n([\s\S]*?)`n---\s*`n") {
        $yaml = $matches[1]
        foreach ($line in ($yaml -split "`n")) {
            if ($line -match "^([^:]+):\s*(.*)$") {
                $key = $matches[1].Trim()
                $val = $matches[2].Trim()
                if ($val -match '^"(.*)"$') { $val = $matches[1] }
                elseif ($val -match "^'(.*)'$") { $val = $matches[1] }
                $meta[$key] = $val
            }
        }
    }
    return $meta
}

function Get-RelativeAssetPath {
    param($depth)
    if ($depth -eq 0) { return "../" } # en/index.html -> ../assets
    # Wait, en/index.html is depth 0 relative to 'en'. 'en' is depth 1 relative to TBOI root.
    # Assets are at src/tboi/assets.
    # Output file: src/tboi/en/index.html
    # Path to assets: ../assets
    
    # Output file: src/tboi/en/parts/p1/c1/s1.html (Depth 3)
    # Path to assets: ../../../../assets
    
    $dots = "../" * ($depth + 1)
    return $dots
}

function Build-Sitemap {
    param($ContentDir, $OutputFile)
    Write-Host "Rebuilding Sitemap..." -ForegroundColor Cyan
    $entries = @()
    $files = Get-ChildItem -Path $ContentDir -Recurse -Filter *.md | Sort-Object FullName
    foreach ($file in $files) {
        $content = Get-Content $file.FullName -Raw -Encoding UTF8
        # Strip frontmatter for parsing if needed, but Parse-Frontmatter handles it.
        $meta = Parse-Frontmatter -content $content
        
        # Relative path from ContentDir (e.g. en/parts/...)
        $relPath = $file.FullName.Substring((Get-Item $ContentDir).FullName.Length + 1).Replace('\', '/')
        if ($relPath -match "^(en|he)/") {
            $lang = $matches[1]
            
            # --- NORMALIZATION LOGIC ---
            $rawPart = if ($meta.ContainsKey('part')) { $meta['part'] } else { "Home" }
            $rawChapter = if ($meta.ContainsKey('chapter')) { $meta['chapter'] } else { "" }
            $rawTitle = if ($meta.ContainsKey('title')) { $meta['title'] } else { $file.Name }
            
            # 1. Cleaning Part Names
            $cleanPart = $rawPart
            # Map known ugly parts to nice ones
            $partMap = @{
                "Part iii life"     = "Part III — Life";
                "Part iii politics" = "Part IV — Politics";
                "Part iv"           = "Part V — Ideas"; 
                "Part iv politics"  = "Part IV — Politics"; # Just in case
                "Part v ideas"      = "Part V — Ideas";
            }
            if ($partMap.ContainsKey($rawPart)) { 
                $cleanPart = $partMap[$rawPart] 
            }
            else {
                # Auto-capitalization fallback if not in map
                if ($cleanPart -match "^part\s+([ivx]+)\s+(?:[-—]\s*)?(.*)$") {
                    $num = $matches[1].ToUpper()
                    $name = (Get-Culture).TextInfo.ToTitleCase($matches[2])
                    $cleanPart = "Part $num — $name"
                    # Write-Host "DEBUG: Auto-capitalized part to '$cleanPart'" -ForegroundColor Cyan
                }
            }

            # 2. Enhancing Chapter Titles
            # Flexible dash matching: [—–-] matches em-dash, en-dash, or hyphen
            $cleanChapter = $rawChapter
            if ($rawTitle -match "^(Chapter \d+: .*?) [—–-] Section") {
                $cleanChapter = $matches[1]
            }
            elseif ($rawTitle -match "^(Chapter \d+: [^—–-]+)$") {
                $cleanChapter = $matches[1]
            }
            # Extract Section Title: Prefer frontmatter, fallback to first H4
            $sectionTitle = if ($meta.ContainsKey('section_title')) { $meta['section_title'] } 
            elseif ($content -match "<h4>(.*?)</h4>") { $matches[1] } 
            else { $null }

            $entries += @{
                path          = $relPath -replace '\.md$', '.html'
                lang          = $lang
                part          = $cleanPart
                chapter       = $cleanChapter
                title         = $rawTitle
                section_title = $sectionTitle
            }
        }
    }
    $entries | ConvertTo-Json -Depth 4 | Set-Content -Path $OutputFile -Encoding UTF8

    # Generate XML Sitemap
    $xmlPath = $OutputFile.Replace(".json", ".xml")
    $xmlContent = '<?xml version="1.0" encoding="UTF-8"?>' + "`n"
    $xmlContent += '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">' + "`n"
    foreach ($e in $entries) {
        # Construct URL (ensure forward slashes)
        $url = "https://www.torahbookofideas.com/" + $e.path
        $xmlContent += "  <url>`n"
        $xmlContent += "    <loc>$url</loc>`n"
        # Optional: <lastmod> if we track file mod time
        $xmlContent += "  </url>`n"
    }
    $xmlContent += '</urlset>'
    Set-Content -Path $xmlPath -Value $xmlContent -Encoding UTF8
}

function Get-BreadcrumbHTML {
    param($Sitemap, $CurrentEntry, $AssetPath)

    $lang = $CurrentEntry.lang
    $homeText = if ($lang -eq 'he') { "ראשי" } else { "Home" }
    $homeUrl = "${AssetPath}${lang}/index.html" 
    
    # 1. Home
    $html = "<div class='breadcrumb-item'><a href='$homeUrl'>$homeText</a></div>"
    $html += "<span class='separator'>&rsaquo;</span>"

    if ($CurrentEntry.part -ne "Home" -and $CurrentEntry.part -ne $null) {
        
        # 2. Part Dropdown
        $parts = @($Sitemap | Where-Object { $_.lang -eq $lang -and $_.part -ne "Home" })
        $groupedParts = $parts | Group-Object part
        
        $partItems = @()
        foreach ($g in $groupedParts) { 
            if ($g.Group.Count -gt 0) {
                $partItems += @{ label = $g.Name; path = $g.Group[0].path } 
            }
        }
        
        $partDropdown = ""
        $hasDropdown = $false
        if ($partItems.Count -gt 0) {
            $hasDropdown = $true
            $partDropdown = "<div class='dropdown-content'>"
            foreach ($item in $partItems) {
                $url = "${AssetPath}$($item.path)"
                $cls = if ($item.label -eq $CurrentEntry.part) { "active" } else { "" }
                $partDropdown += "<a href='$url' class='$cls'>$($item.label)</a>"
            }
            $partDropdown += "</div>"
        }
        
        $currPartUrl = "#" 
        $currPartObj = $partItems | Where-Object { $_.label -eq $CurrentEntry.part } | Select-Object -First 1
        if ($currPartObj) { $currPartUrl = "${AssetPath}$($currPartObj.path)" }

        # Add 'dropdown' class to parent if needed
        $parentClass = "breadcrumb-item" + $(if ($hasDropdown) { " dropdown" } else { "" })
        $html += "<div class='$parentClass'><a href='$currPartUrl'>$($CurrentEntry.part)</a>$partDropdown</div>"
        $html += "<span class='separator'>&rsaquo;</span>"
        
        # 3. Chapter Dropdown
        if ($CurrentEntry.chapter) {
            $chapters = @($Sitemap | Where-Object { $_.lang -eq $lang -and $_.part -eq $CurrentEntry.part -and $_.chapter })
            $groupedChapters = $chapters | Group-Object chapter
            
            $chapItems = @()
            foreach ($g in $groupedChapters) { 
                if ($g.Group.Count -gt 0) {
                    $chapItems += @{ label = $g.Name; path = $g.Group[0].path } 
                }
            }
            
            # Sort numerically
            $chapItems = $chapItems | Sort-Object { 
                if ($_.label -match "(\d+)") { [int]$matches[1] } else { 999 } 
            }
             
            $chapDropdown = ""
            $hasChapDropdown = $false
            if ($chapItems.Count -gt 0) {
                $hasChapDropdown = $true
                $chapDropdown = "<div class='dropdown-content'>"
                foreach ($item in $chapItems) {
                    $url = "${AssetPath}$($item.path)"
                    $cls = if ($item.label -eq $CurrentEntry.chapter) { "active" } else { "" }
                    $cleanLabel = $item.label -replace "^Chapter\s*", ""
                    $chapDropdown += "<a href='$url' class='$cls'>$cleanLabel</a>"
                }
                $chapDropdown += "</div>"
            }
             
            $parentClass = "breadcrumb-item" + $(if ($hasChapDropdown) { " dropdown" } else { "" })
            $html += "<div class='$parentClass'><a href='#'>$($CurrentEntry.chapter)</a>$chapDropdown</div>"
            $html += "<span class='separator'>&rsaquo;</span>"
             
            # 4. Section Dropdown
            $sections = @($Sitemap | Where-Object { $_.lang -eq $lang -and $_.part -eq $CurrentEntry.part -and $_.chapter -eq $CurrentEntry.chapter })
            
            $sectDropdown = ""
            $hasSectDropdown = $false
            if ($sections.Count -gt 0) {
                $hasSectDropdown = $true
                $sectDropdown = "<div class='dropdown-content'>"
                foreach ($s in $sections) {
                    $url = "${AssetPath}$($s.path)"
                    $cls = if ($s.title -eq $CurrentEntry.title) { "active" } else { "" }
                    $cleanLabel = $s.title -replace "^.*—\s*", ""
                    if ($s.section_title) {
                        $cleanLabel = "${cleanLabel}: $($s.section_title)"
                    }
                    $sectDropdown += "<a href='$url' class='$cls' title='$($s.title)'>$cleanLabel</a>"
                }
                $sectDropdown += "</div>"
            }
             
            $cleanTitle = $CurrentEntry.title -replace "^.*—\s*", ""
            if ($CurrentEntry.section_title) {
                $cleanTitle = "${cleanTitle}: $($CurrentEntry.section_title)"
            }
            $dispTitle = if ($cleanTitle.Length -gt 40) { $cleanTitle.Substring(0, 37) + "..." } else { $cleanTitle }
            
            $parentClass = "breadcrumb-item" + $(if ($hasSectDropdown) { " dropdown" } else { "" })
            $html += "<div class='$parentClass'><span>$dispTitle</span>$sectDropdown</div>"
        }
    }
    return $html
}

# --- Main Build Logic ---

$LayoutHTML = Get-Content -Path (Join-Path $TemplateDir "layout.html") -Raw


# Sitemap Logic
$SitemapPath = Join-Path $OutputDir "sitemap.json"
if ($RebuildSitemap -or -not (Test-Path $SitemapPath)) {
    Build-Sitemap -ContentDir $ContentDir -OutputFile $SitemapPath
}
$Sitemap = Get-Content $SitemapPath | ConvertFrom-Json

# Get files to build (single file or all)
if ($SingleFile -ne "") {
    if (Test-Path $SingleFile) {
        $Files = @(Get-Item $SingleFile)
        Write-Host "Single-file mode: Building $SingleFile"
    }
    else {
        Write-Error "File not found: $SingleFile"
        exit 1
    }
}
else {
    $Files = Get-ChildItem -Path $ContentDir -Recurse -Filter *.md
}

foreach ($file in $Files) {
    Write-Host "Building: $($file.Name)"
    
    # 1. Read Content
    $rawContent = Get-Content $file.FullName -Raw
    if ($rawContent.Length -gt 0 -and $rawContent[0] -eq [char]0xFEFF) {
        $rawContent = $rawContent.Substring(1)
    }
    
    # 2. Parse Frontmatter & Body
    $meta = Parse-Frontmatter -content $rawContent
    $bodyHtml = Convert-MarkdownToHTML -markdown $rawContent
    
    # 3. Determine Language & Output Path
    # src/tboi/content/en/parts/... -> src/tboi/en/parts/...
    $relativePath = $file.FullName.Substring((Get-Item $ContentDir).FullName.Length)
    $outputPath = (Join-Path $OutputDir ("$relativePath" -replace '\.md$', '.html'))
    
    $lang = "en"
    if ($relativePath.StartsWith("\he\") -or $relativePath.StartsWith("/he/")) { $lang = "he" }
    
    # 4. Calculate Depth
    $pathParts = $relativePath.Trim('\', '/').Split('\')
    # pathParts[0] is 'en' or 'he'.
    # If file is en/index.md, parts=['en','index.md']. Depth of FOLDER is 0 relative to en.
    # If file is en/parts/p1.md, parts=['en','parts','p1.md']. Depth is 1.
    $fileDepth = $pathParts.Count - 2 
    if ($fileDepth -lt 0) { $fileDepth = 0 }
    
    $assetPath = Get-RelativeAssetPath -depth $fileDepth
    
    # Breadcrumbs Logic
    $relPathClean = $relativePath.Trim('\', '/').Replace('\', '/').Replace('.md', '.html')
    $currentEntry = $Sitemap | Where-Object { $_.path -eq $relPathClean } | Select-Object -First 1
    
    $breadcrumbHtml = ""
    if ($currentEntry) {
        $breadcrumbHtml = Get-BreadcrumbHTML -Sitemap $Sitemap -CurrentEntry $currentEntry -AssetPath $assetPath
    }
    
    # 5. Inject into Layout
    $pageHtml = $LayoutHTML
    
    # Global Replacements
    $pageHtml = $pageHtml.Replace("{{LANG_CODE}}", $lang)
    $pageHtml = $pageHtml.Replace("{{DIR}}", $(if ($lang -eq 'he') { 'rtl' }else { 'ltr' }))
    $pageHtml = $pageHtml.Replace("{{PAGE_TITLE}}", $meta['title'])
    
    # SEO Meta
    $pageDesc = if ($meta.ContainsKey('description')) { $meta['description'] } else { "The Torah Book of Ideas - A journey through wisdom, faith, and understanding." }
    $pageHtml = $pageHtml.Replace("{{PAGE_DESCRIPTION}}", $pageDesc)
    
    # Canonical URL
    $canonicalUrl = $BaseUrl + "/" + $relativePath.Trim('\', '/').Replace('\', '/').Replace('.md', '.html')
    $pageHtml = $pageHtml.Replace("{{CANONICAL_URL}}", $canonicalUrl)

    $pageHtml = $pageHtml.Replace("{{BREADCRUMB_HTML}}", $breadcrumbHtml)

    $pageHtml = $pageHtml.Replace("{{PART_TITLE}}", $meta['part'])
    $pageHtml = $pageHtml.Replace("{{CHAPTER_TITLE}}", $meta['chapter'])
    $pageHtml = $pageHtml.Replace("{{SECTION_TITLE}}", $meta['title']) # Reuse title for H3
    $pageHtml = $pageHtml.Replace("{{CONTENT_BODY}}", $bodyHtml)
    $pageHtml = $pageHtml.Replace("{{ASSET_PATH}}", $assetPath)
    


    # Nav Links
    # Fix Part Index Link: Find the first section of this part in the sitemap
    $partFirstSection = $Sitemap | Where-Object { $_.lang -eq $lang -and $_.part -eq $meta['part'] } | Select-Object -First 1
    $partIndexUrl = "#"
    if ($partFirstSection) {
        $partIndexUrl = "${assetPath}$($partFirstSection.path)"
    }
    $pageHtml = $pageHtml.Replace("{{PART_INDEX_LINK}}", $partIndexUrl)

    
    # Auto-Calculate Prev/Next from Sitemap
    $prevBtn = ""
    $nextBtn = ""
    
    if ($currentEntry) {
        # Get all entries for this language, ordered (Sitemap should already be ordered)
        $langEntries = $Sitemap | Where-Object { $_.lang -eq $lang }
        $currIdx = $langEntries.IndexOf($currentEntry)
        
        if ($currIdx -gt 0) {
            $prevEntry = $langEntries[$currIdx - 1]
            $url = "${assetPath}$($prevEntry.path)"
            # Card Style Prev
            $prevBtn = "<a href='$url' class='nav-card prev'>"
            $prevBtn += "<div class='label'>" + $(if ($lang -eq 'he') { 'הקודם' }else { 'Previous' }) + "</div>"
            $prevBtn += "<div class='title'>$($prevEntry.title)</div>"
            $prevBtn += "</a>"
        }
        
        if ($currIdx -lt ($langEntries.Count - 1)) {
            $nextEntry = $langEntries[$currIdx + 1]
            $url = "${assetPath}$($nextEntry.path)"
            # Card Style Next
            $nextBtn = "<a href='$url' class='nav-card next'>"
            $nextBtn += "<div class='label'>" + $(if ($lang -eq 'he') { 'הבא' }else { 'Next' }) + "</div>"
            $nextBtn += "<div class='title'>$($nextEntry.title)</div>"
            $nextBtn += "</a>"
        }
    }
    
    $pageHtml = $pageHtml.Replace("{{PREV_BUTTON}}", $prevBtn)
    $pageHtml = $pageHtml.Replace("{{NEXT_BUTTON}}", $nextBtn)
    
    # Lang Toggle Text
    $langText = if ($lang -eq 'he') { "EN" } else { "HE" } # Toggle target
    $pageHtml = $pageHtml.Replace("{{LANG_TOGGLE_TEXT}}", $langText)

    # 6. Write File
    $outputDirFinal = Split-Path $outputPath
    if (-not (Test-Path $outputDirFinal)) { New-Item -ItemType Directory -Force -Path $outputDirFinal | Out-Null }
    Set-Content -Path $outputPath -Value $pageHtml -Encoding UTF8
}

Write-Host "Build Complete!" -ForegroundColor Green
