
$files = Get-ChildItem -Path "src/tboi/content" -Recurse -Filter *.md

foreach ($file in $files) {
    $content = Get-Content -Path $file.FullName -Raw
    # Regex to match <p>--- ... ---</p> blocks including newlines
    if ($content -match "(?ms)<p>---\s+title:.*?---\s*</p>") {
        Write-Host "Cleaning $($file.Name)"
        $clean = $content -replace "(?ms)<p>---\s+title:.*?---\s*</p>", ""
        Set-Content -Path $file.FullName -Value $clean -NoNewline
    }
}
Write-Host "Cleanup Complete"
