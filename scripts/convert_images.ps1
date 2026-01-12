
# Script to convert [IMAGE: filename] to explicit HTML in text source files
# This allows the user to manually control sizing in the source TXT files.

$englishDir = "c:\myantigravity\cantorwilliam\src\tboi\split_book"
$hebrewDir = "c:\myantigravity\cantorwilliam\src\tboi\split_book_he"

# HTML Template to use
# We use a wrapper div to center and control layout, and img with max-width relative to it.
# Note: The depths are different.
# EN: parts/part_X/chapter_Y/section_Z.html -> ../../../images/
# HE: he/parts/part_X/chapter_Y/section_Z.html -> ../../../../images/

function Convert-Images($dir, $depth) {
    Write-Host "Processing directory: $dir (Depth: $depth)" -ForegroundColor Cyan
    
    $files = Get-ChildItem -Path $dir -Recurse -Filter "*.txt"
    foreach ($file in $files) {
        $content = Get-Content -Path $file.FullName -Raw -Encoding UTF8
        
        # Regex to find [IMAGE: filename]
        # We capture the filename.
        if ($content -match '\[IMAGE:\s*(.*?)\]') {
            Write-Host "  Found images in $($file.Name)"
            
            # Perform replacement
            # We want to replace ALL occurrences
            # Using ScriptBlock for dynamic replacement if processed line by line, but simple regex replace is easier here if pattern is uniform.
            
            # Pattern: \[IMAGE:\s*(.*?)\]
            # Replacement:
            # <div class="feature-image" style="width: 80%; margin: 1.5rem auto;">
            #    <img src="$depth/images/$1" alt="Book Image">
            # </div>
            
            # Case insensitive
            $newContent = [Regex]::Replace($content, '(?i)\[IMAGE:\s*(.*?)\]', {
                    param($match)
                    $imgName = $match.Groups[1].Value.Trim()
                    return @"
<div class="feature-image" style="width: 80%; margin: 1.5rem auto;">
    <img src="$depth/images/$imgName" alt="Book Image" style="width: 100%; height: auto;">
</div>
"@
                })
            
            if ($newContent -ne $content) {
                Set-Content -Path $file.FullName -Value $newContent -Encoding UTF8
                Write-Host "    Updated $($file.Name)" -ForegroundColor Green
            }
        }
    }
}

# Process English
Convert-Images -dir $englishDir -depth "../../.."

# Process Hebrew
Convert-Images -dir $hebrewDir -depth "../../../.."

Write-Host "Bulk image conversion complete." -ForegroundColor Green
