# Generate Search Index
# Creates search_index.json with current content from all markdown files

$ContentDir = "$PSScriptRoot/../content"
$OutputFile = "$PSScriptRoot/../search_index.json"

Write-Host "Generating search index..." -ForegroundColor Cyan

$searchEntries = @()

# Get all markdown files
$files = Get-ChildItem -Path $ContentDir -Recurse -Filter *.md | Where-Object { $_.Name -ne 'README.md' }

foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    
    # Parse frontmatter
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
    
    # Get the relative path
    $relPath = $file.FullName.Substring((Get-Item $ContentDir).FullName.Length + 1).Replace('\', '/')
    
    # Only process en/ files
    if ($relPath -match "^en/") {
        # Convert to HTML path
        $htmlPath = $relPath -replace '\.md$', '.html'
        
        # Extract text content (remove frontmatter and HTML tags)
        $textContent = $content -replace "(?s)^---\s*`n.*?`n---\s*`n", ""
        $textContent = $textContent -replace '<[^>]+>', ' '
        $textContent = $textContent -replace '\s+', ' '  # Normalize whitespace
        $textContent = $textContent.Trim()
        
        # Limit content length for search index
        if ($textContent.Length -gt 1500) {
            $textContent = $textContent.Substring(0, 1500)
        }
        
        # Clean up part name
        $partName = if ($meta.ContainsKey('part')) { $meta['part'] } else { "" }
        
        # Normalize part names to consistent format: "Part I — Name"
        if ($partName -match "^[Pp]art\s+([ivxIVX]+)\s*[-—–]?\s*(.*)$") {
            $romanNum = $matches[1].ToUpper()
            $partTitle = $matches[2].Trim()
            if ($partTitle) {
                # Capitalize first letter of each word in title
                $partTitle = (Get-Culture).TextInfo.ToTitleCase($partTitle.ToLower())
                $partName = "Part $romanNum — $partTitle"
            }
            else {
                $partName = "Part $romanNum"
            }
        }
        
        # Build entry
        $entry = @{
            title   = if ($meta.ContainsKey('title')) { $meta['title'] } else { $file.Name }
            part    = $partName
            chapter = if ($meta.ContainsKey('chapter')) { $meta['chapter'] } else { "" }
            url     = $htmlPath
            content = $textContent
            id      = ($htmlPath -replace '[/\\.]', '-')
        }
        
        $searchEntries += $entry
        Write-Host "  Indexed: $($entry.title)" -ForegroundColor Gray
    }
}

# Write to JSON
$searchEntries | ConvertTo-Json -Depth 4 -Compress | Set-Content -Path $OutputFile -Encoding UTF8
Write-Host "Search index generated: $OutputFile" -ForegroundColor Green
Write-Host "Total entries: $($searchEntries.Count)" -ForegroundColor Green

# Convert to JavaScript
$jsonContent = Get-Content $OutputFile -Raw
"const SEARCH_INDEX = $jsonContent;" | Set-Content -Path ($OutputFile -replace '\.json$', '.js') -Encoding UTF8
Write-Host "JavaScript version created: $($OutputFile -replace '\.json$', '.js')" -ForegroundColor Green
