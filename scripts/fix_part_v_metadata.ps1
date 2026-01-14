
$targetDir = "c:\myantigravity\cantorwilliam\src\tboi_backup_state\content\en\parts\part_v_ideas"
$files = Get-ChildItem -Path $targetDir -Recurse -Filter "*.md"

$count = 0

foreach ($file in $files) {
    $content = Get-Content -Path $file.FullName -Raw
    # Check for incorrect Part lines (Part iv, Part IV) in Part V directory
    if ($content -match 'part:\s*"Part\s*iv"') {
        $newContent = $content -replace 'part:\s*"Part\s*iv"', 'part: "Part V"'
        Set-Content -Path $file.FullName -Value $newContent -Encoding UTF8
        Write-Host "Fixed: $($file.Name)"
        $count++
        
        # Trigger single file build for immediate update
        # & "c:\myantigravity\cantorwilliam\src\tboi_backup_state\scripts\build.ps1" -SingleFile $file.FullName
    }
}

Write-Host "Total files fixed: $count"
