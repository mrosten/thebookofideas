# Function to divide a file into sections of approximately 120 lines
function Split-IntoSections {
    param([string]$FilePath, [string]$OutputDir)
    
    $lines = Get-Content $FilePath -Encoding UTF8
    $totalLines = $lines.Length
    $sectionSize = 120
    $sectionNum = 1
    $romanNumerals = @('i', 'ii', 'iii', 'iv', 'v', 'vi', 'vii', 'viii', 'ix', 'x', 
        'xi', 'xii', 'xiii', 'xiv', 'xv', 'xvi', 'xvii', 'xviii', 'xix', 'xx')
    
    $startLine = 0
    while ($startLine -lt $totalLines) {
        $endLine = [Math]::Min($startLine + $sectionSize - 1, $totalLines - 1)
        
        # For sections not at the end, look for natural break (bullet point "·") around target
        if ($endLine -lt $totalLines - 1) {
            $searchStart = [Math]::Max($startLine + 90, $startLine)
            $searchEnd = [Math]::Min($startLine + 140, $totalLines - 1)
            
            for ($i = $searchStart; $i -le $searchEnd; $i++) {
                if ($lines[$i] -match '^\s*·\s*$' -or $lines[$i] -match '^\s*$' -and $i -gt $searchStart) {
                    $endLine = $i - 1
                    break
                }
            }
        }
        
        $sectionName = "section_$($romanNumerals[$sectionNum - 1]).txt"
        $lines[$startLine..$endLine] | Set-Content -Path "$OutputDir\$sectionName" -Encoding UTF8
        Write-Host "  Created $sectionName (lines $($startLine + 1)-$($endLine + 1))"
        
        $startLine = $endLine + 1
        $sectionNum++
        
        if ($sectionNum -gt 20) { break }  # Safety limit
    }
}

# Process remaining chapters in part_i (chapter_02 onwards)
Write-Host "=== Processing part_i remaining chapters ===" -ForegroundColor Cyan
$part_i_dirs = Get-ChildItem "part_i" -Directory | Where-Object { $_.Name -ne "chapter_01-god-the-song-of-god" }
foreach ($dir in $part_i_dirs) {
    $chapterFile = Get-ChildItem "$($dir.FullName)\*.txt" | Select-Object -First 1
    if ($chapterFile) {
        Write-Host "`nProcessing $($dir.Name)..."
        Split-IntoSections -FilePath $chapterFile.FullName -OutputDir $dir.FullName
    }
}

# Process parts II through V
$parts = @("part_ii", "part_iii_life", "part_iii_politics", "part_iv", "part_v")
foreach ($part in $parts) {
    Write-Host "`n=== Processing $part ===" -ForegroundColor Cyan
    $files = Get-ChildItem "$part\*.txt"
    foreach ($file in $files) {
        $folderName = $file.BaseName
        $newFolder = "$part\$folderName"
        
        # Create folder and move file
        New-Item -ItemType Directory -Path $newFolder -Force | Out-Null
        $newFilePath = "$newFolder\$($file.Name)"
        Move-Item $file.FullName -Destination $newFilePath
        Write-Host "`nCreated folder and moved: $folderName"
        
        # Split into sections
        Split-IntoSections -FilePath $newFilePath -OutputDir $newFolder
    }
}

Write-Host "`n=== All done! ===" -ForegroundColor Green
