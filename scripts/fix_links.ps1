$path = 'c:\myantigravity\cantorwilliam\src\tboi_backup_state\content\en\contents.md'
$txt = Get-Content $path -Raw
$txt = $txt -replace 'section_i.html', 'section_01.html'
$txt = $txt -replace 'section_ii.html', 'section_02.html'
$txt = $txt -replace 'section_iii.html', 'section_03.html'
$txt = $txt -replace 'section_iv.html', 'section_04.html'
$txt = $txt -replace 'section_v.html', 'section_05.html'
Set-Content $path -Value $txt
Write-Host "Links updated in $path"
