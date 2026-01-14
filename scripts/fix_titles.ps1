$files = Get-ChildItem -Path "src/tboi_backup_state/content/en/parts" -Recurse -Filter *.md
$updatedCount = 0

foreach ($f in $files) {
    $content = Get-Content $f.FullName -Raw -Encoding UTF8
    
    # Skip if already has section_title
    if ($content -match "section_title:") { continue }
    
    # Check for H3 or H4 to use as title
    $title = $null
    if ($content -match "<h3>(.*?)</h3>") { 
        $title = $matches[1] 
    }
    elseif ($content -match "<h4>(.*?)</h4>") {
        $title = $matches[1]
    }

    if ($title) {
        # Clean title (remove emojis if desired, or keep them)
        $cleanTitle = $title.Trim()
        
        # Inject into frontmatter
        # Assumes frontmatter ends with ---
        # We replace the last --- of the frontmatter block
        
        if ($content -match "(?ms)^(---\r?\n[\s\S]*?)(\r?\n---)") {
            $fm = $matches[1]
            $end = $matches[2]
            
            # Construct new frontmatter
            $newFM = "$fm`nsection_title: `"$cleanTitle`"$end"
            
            # Replace in content
            $newContent = $content -replace "(?ms)^---\r?\n[\s\S]*?\r?\n---", $newFM
            
            Set-Content -Path $f.FullName -Value $newContent -Encoding UTF8
            Write-Host "Updated $($f.Name): $cleanTitle"
            $updatedCount++
        }
    }
}

Write-Host "Total files updated: $updatedCount"
