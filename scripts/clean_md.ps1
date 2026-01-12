
$files = Get-ChildItem -Path "src/tboi/content" -Recurse -Filter *.md
foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw
    if ($content -match '(?ms)<hr class="divider">\s*title:.*?<hr class="divider">') {
        Write-Host "Cleaning $($file.Name)"
        $content = $content -replace '(?ms)<hr class="divider">\s*title:.*?<hr class="divider">', ''
        Set-Content -Path $file.FullName -Value $content -Encoding UTF8
    }
}
