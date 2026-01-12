
$files = Get-ChildItem -Path "src/tboi/content/he/parts" -Recurse -Filter *.md

foreach ($file in $files) {
    $content = Get-Content -Path $file.FullName -Raw
    
    # Replace Part names
    $content = $content -replace 'part: "part i"', 'part: "חלק א'' — פילוסופיה"'
    $content = $content -replace 'part: "part ii"', 'part: "חלק ב'' — הלכה"'
    $content = $content -replace 'part: "part iii"', 'part: "חלק ג'' — חיים"'
    $content = $content -replace 'part: "part iv politics"', 'part: "חלק ד'' — פוליטיקה"'
    $content = $content -replace 'part: "part v ideas"', 'part: "חלק ה'' — רעיונות"'
    $content = $content -replace 'part: "part vi christianity"', 'part: "חלק ו'' — נצרות"'
    
    # Replace Chapter names (generic regex)
    # chapter: "chapter 01" -> chapter: "פרק 1"
    # chapter: "chapter 10" -> chapter: "פרק 10"
    
    if ($content -match 'chapter: "chapter 0?(\d+)"') {
        $num = $matches[1]
        $content = $content -replace 'chapter: "chapter 0?(\d+)"', "chapter: `"פרק $num`""
    }
    
    Set-Content -Path $file.FullName -Value $content -NoNewline
}
Write-Host "Hebrew Frontmatter Localization Complete"
