
# migrate_content.ps1
# Automates the migration of legacy HTML content to the new Markdown format.

param(
    [string]$SourceRoot = (Resolve-Path "$PSScriptRoot\..\en").Path,
    [string]$DestRoot = "$PSScriptRoot\..\content\en"
)

# Function to extract content from HTML
function Get-HtmlContent {
    param([string]$path)
    
    if (-not (Test-Path $path)) { return $null }
    
    $html = Get-Content -Path $path -Raw
    
    # 1. Extract Title (Regex for <title> or first <h3> in content)
    $title = ""
    if ($html -match "<title>(.*?)</title>") {
        $title = $matches[1].Trim() -replace '"', '' -replace 'The Torah Book of Ideas - ', ''
    }
    
    # 2. Extract Previous/Next Links
    $prev = ""
    $next = ""
    # Check for class...href
    if ($html -match 'class=["'']nav-btn prev["''][^>]*href=["''](.*?)["'']') { $prev = $matches[1] }
    elseif ($html -match 'href=["''](.*?)["''][^>]*class=["'']nav-btn prev["'']') { $prev = $matches[1] }
    
    if ($html -match 'class=["'']nav-btn next["''][^>]*href=["''](.*?)["'']') { $next = $matches[1] }
    elseif ($html -match 'href=["''](.*?)["''][^>]*class=["'']nav-btn next["'']') { $next = $matches[1] }
    
    # 3. Extract Body Content (Everything inside <div class="content-card">...</div>)
    # Note: This regex is simple and might need adjustment if nested divs are complex.
    # Using a greedy match for the content card content.
    $content = ""
    if ($html -match '(?ms)<div class="content-card">\s*(.*?)\s*<div class="page-nav">') {
        $content = $matches[1].Trim()
    }
    elseif ($html -match '(?ms)<div class="content-card">\s*(.*?)\s*</div>\s*<div class="page-nav">') {
        $content = $matches[1].Trim()
    }
    
    # Clean up content
    # Remove the <h3> title if it duplicates the frontmatter title logic
    $content = $content -replace '(?i)\s*<h3>.*?</h3>', ''
    
    
    # Remove POLLUTED frontmatter from previous builds (text within horizontal rules)
    # Broader regex to catch any block starting with hr+title and ending with hr
    $content = $content -replace '(?ms)<hr class="divider">\s*title:.*?<hr class="divider">', ''
    
    return @{
        Title = $title
        Prev  = $prev
        Next  = $next
        Body  = $content
    }
}

# Function to Process Directory
function Process-Directory {
    param($targetDir)
    
    $files = Get-ChildItem -Path $targetDir -Filter "*.html" -Recurse
    
    foreach ($file in $files) {
        # Skip index files
        if ($file.Name -eq "index.html") { continue }
        
        Write-Host "Processing: $($file.FullName)"
        
        # Calculate relative path to mirror structure
        $relPath = $file.FullName.Substring($SourceRoot.Length)
        $destPath = Join-Path $DestRoot $relPath 
        $destPath = $destPath -replace "\.html$", ".md"
        
        $destDir = Split-Path $destPath
        if (-not (Test-Path $destDir)) { New-Item -ItemType Directory -Path $destDir -Force | Out-Null }
        
        # Extract Data
        $data = Get-HtmlContent -path $file.FullName
        
        if (-not $data.Body) {
            Write-Warning "No content found for $($file.Name)"
            continue
        }

        # Determine Part/Chapter/etc from path for metadata?
        # For now, just use what we scraped. 
        # We can infer 'Part' and 'Chapter' from the directory structure if needed, 
        # but the request asked to "Extract Title, Prev, Next".
        
        # Construct Markdown
        $md = "---`n"
        $md += 'title: "{0}"' -f $data.Title + "`n"
        # We can try to infer part/chapter from the path for better sidebar logic later,
        # but for now let's leave them generic or extract if possible.
        # The build script relies on 'part' and 'chapter' frontmatter for the sidebar active state?
        # Actually build.ps1 uses the directory structure for sidebar generation usually, 
        # unless it uses frontmatter to *highlight* the active item.
        # Let's add placeholders or try to parse.
        
        $parts = $relPath -split "\\"
        # parts[0] is empty (start slash), [1] is 'parts', [2] is 'part_iv_...'
        if ($parts.Count -ge 4) {
            # naive extraction
            $md += 'part: "{0}"' -f ($parts[2] -replace "_", " " -replace "part", "Part") + "`n"
            $md += 'chapter: "{0}"' -f ($parts[3] -replace "_", " " -replace "chapter", "Chapter") + "`n"
        }
        
        $md += 'prev: "{0}"' -f $data.Prev + "`n"
        $md += 'next: "{0}"' -f $data.Next + "`n"
        $md += "---`n`n"
        
        $md += $data.Body
        
        Set-Content -Path $destPath -Value $md -Encoding UTF8
    }
}

# --- Main Execution ---

Write-Host "Starting Content Migration..."

# 1. Process English
Write-Host "Migrating English..."
Process-Directory -targetDir "$SourceRoot\parts"

# 2. Process Hebrew (Adjust paths)
# Assuming parallel structure
$HeSource = (Resolve-Path "$PSScriptRoot\..\he").Path
$HeDest = "$PSScriptRoot\..\content\he"

Write-Host "Migrating Hebrew..."
# We need to redefine the global DestRoot/SourceRoot for the function or pass them
# Simplest is to just loop manually or call function with adjusted context.
# Since Process-Directory uses global variables, let's just update them locally or rewrite the function call.
# Better: Just run the logic again.

$files = Get-ChildItem -Path "$HeSource\parts" -Filter "*.html" -Recurse
foreach ($file in $files) {
    if ($file.Name -eq "index.html") { continue }
    Write-Host "Processing HE: $($file.FullName)"
     
    $relPath = $file.FullName.Substring($HeSource.Length)
    $destPath = Join-Path $HeDest $relPath
    $destPath = $destPath -replace "\.html$", ".md"
     
    $destDir = Split-Path $destPath
    if (-not (Test-Path $destDir)) { New-Item -ItemType Directory -Path $destDir -Force | Out-Null }
     
    $data = Get-HtmlContent -path $file.FullName
    if (-not $data.Body) { continue }
     
    $md = "---`n"
    $md += 'title: "{0}"' -f $data.Title + "`n"
     
    $parts = $relPath -split "\\"
    if ($parts.Count -ge 4) {
        $md += 'part: "{0}"' -f ($parts[2] -replace "_", " ") + "`n"
        $md += 'chapter: "{0}"' -f ($parts[3] -replace "_", " ") + "`n"
    }
     
    $md += 'prev: "{0}"' -f $data.Prev + "`n"
    $md += 'next: "{0}"' -f $data.Next + "`n"
    $md += "---`n`n"
    $md += $data.Body
     
    Set-Content -Path $destPath -Value $md -Encoding UTF8
}

Write-Host "Migration Complete."
