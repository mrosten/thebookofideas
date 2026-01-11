# Split all remaining sections into chapters
# Section II - Halachah (2207 lines, 7 chapters)
$lines = Get-Content "2-section_ii.txt" -Encoding UTF8
Write-Host "Section II has $($lines.Length) lines"
$lines[0..248] | Set-Content -Path "section_ii/chapter_01-principles-of-halacha.txt" -Encoding UTF8
$lines[249..460] | Set-Content -Path "section_ii/chapter_02-prayer.txt" -Encoding UTF8
$lines[461..726] | Set-Content -Path "section_ii/chapter_03-shabbat.txt" -Encoding UTF8
$lines[727..816] | Set-Content -Path "section_ii/chapter_04-festivals.txt" -Encoding UTF8
$lines[817..860] | Set-Content -Path "section_ii/chapter_05-kashrut.txt" -Encoding UTF8
$lines[861..1160] | Set-Content -Path "section_ii/chapter_06-israel.txt" -Encoding UTF8
$lines[1161..($lines.Length - 1)] | Set-Content -Path "section_ii/chapter_07-marriage-and-family.txt" -Encoding UTF8
Write-Host "Section II split into 7 chapters"

# Section III-Life (3376 lines, 7 chapters)
$lines = Get-Content "3-section_iii-life" -Encoding UTF8
Write-Host "Section III-Life has $($lines.Length) lines"
$lines[0..486] | Set-Content -Path "section_iii_life/chapter_01-family.txt" -Encoding UTF8
$lines[487..1048] | Set-Content -Path "section_iii_life/chapter_02-marriage.txt" -Encoding UTF8
$lines[1049..1320] | Set-Content -Path "section_iii_life/chapter_03-sex.txt" -Encoding UTF8
$lines[1321..2322] | Set-Content -Path "section_iii_life/chapter_04-ways-of-life.txt" -Encoding UTF8
$lines[2323..2442] | Set-Content -Path "section_iii_life/chapter_05-friendship.txt" -Encoding UTF8
$lines[2443..2826] | Set-Content -Path "section_iii_life/chapter_06-success.txt" -Encoding UTF8
$lines[2827..($lines.Length - 1)] | Set-Content -Path "section_iii_life/chapter_07-saints.txt" -Encoding UTF8
Write-Host "Section III-Life split into 7 chapters"

# Section III-Politics (1732 lines, 3 chapters)
$lines = Get-Content "4-section_iii-politics" -Encoding UTF8
Write-Host "Section III-Politics has $($lines.Length) lines"
$lines[0..914] | Set-Content -Path "section_iii_politics/chapter_01-politics-and-the-torah.txt" -Encoding UTF8
$lines[915..1166] | Set-Content -Path "section_iii_politics/chapter_02-the-baal-teshuva-movement.txt" -Encoding UTF8
$lines[1167..($lines.Length - 1)] | Set-Content -Path "section_iii_politics/chapter_03-the-usa.txt" -Encoding UTF8
Write-Host "Section III-Politics split into 3 chapters"

# Section IV-Ideas (4737 lines, 4 chapters)
$lines = Get-Content "5-section_iv-ideas.txt" -Encoding UTF8
Write-Host "Section IV-Ideas has $($lines.Length) lines"
$lines[0..2070] | Set-Content -Path "section_iv/chapter_01-ideas-in-kabbalah.txt" -Encoding UTF8
$lines[2071..3896] | Set-Content -Path "section_iv/chapter_02-roots-of-science.txt" -Encoding UTF8
$lines[3897..4296] | Set-Content -Path "section_iv/chapter_03-rav-nachman.txt" -Encoding UTF8
$lines[4297..($lines.Length - 1)] | Set-Content -Path "section_iv/chapter_04-final-ideas.txt" -Encoding UTF8
Write-Host "Section IV-Ideas split into 4 chapters"

# Section V-Christianity (2676 lines, 4 chapters)
$lines = Get-Content "6-section_v-christianity.txt" -Encoding UTF8
Write-Host "Section V-Christianity has $($lines.Length) lines"
$lines[0..1584] | Set-Content -Path "section_v/chapter_01-jesus-christ.txt" -Encoding UTF8
$lines[1585..2004] | Set-Content -Path "section_v/chapter_02-christianity.txt" -Encoding UTF8
$lines[2005..($lines.Length - 1)] | Set-Content -Path "section_v/chapter_03-jesus-and-judaism.txt" -Encoding UTF8
Write-Host "Section V-Christianity split into 3 chapters"

Write-Host "`nAll sections split successfully!"
Get-ChildItem -Recurse section_* | Where-Object { $_.Extension -eq ".txt" } | ForEach-Object { Write-Host "$($_.Directory.Name)/$($_.Name)" }
