$dir = "c:\myantigravity\cantorwilliam\src\thebookofideas\content\en\parts\part_vi_christianity\chapter_03"
$files = Get-ChildItem $dir -Filter "section_*.md"
foreach ($file in $files | Sort-Object Name) {
    if ($file.Name -match "section_(\d+)\.md") {
        $num = [int]$matches[1]
        if ($num -gt 1) {
            $prev = $num - 1
            $newName = "section_{0:D2}.md" -f $prev
            $newPath = Join-Path $dir $newName
            $content = Get-Content $file.FullName -Raw
            $romanMap = @{ 2="II"; 3="III"; 4="IV"; 5="V"; 6="VI"; 7="VII"; 8="VIII"; 9="IX" }
            $prevMap = @{ 2="I"; 3="II"; 4="III"; 5="IV"; 6="V"; 7="VI"; 8="VII"; 9="VIII" }
            if ($romanMap.ContainsKey($num)) {
                $oldR = $romanMap[$num]
                $newR = $prevMap[$num]
                $content = $content -replace "— Section $oldR", "— Section $newR"
            }
            Set-Content $file.FullName $content
            Rename-Item $file.FullName $newName -Force
            Write-Host "Renamed $($file.Name) to $newName"
        }
    }
}
