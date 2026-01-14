$files = Get-ChildItem -Path "src/tboi_backup_state/content/en/parts" -Recurse -Filter *.md
$missing = @()

foreach ($f in $files) {
    $content = Get-Content $f.FullName -Raw
    $hasFM = $content -match "section_title:"
    $hasH4 = $content -match "<h4>(.*?)</h4>"
    
    if (-not $hasFM -and -not $hasH4) {
        # Try to find an H3 to propose as title
        $h3 = "Unknown"
        if ($content -match "<h3>(.*?)</h3>") { $h3 = $matches[1] }
        
        $missing += [PSCustomObject]@{
            File     = $f.Name
            Path     = $f.FullName
            Proposed = $h3
        }
    }
}

$missing | Select-Object File, Proposed | Format-Table -AutoSize
Write-Host "Total Missing: $($missing.Count)"
