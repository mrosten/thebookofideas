# Section II - Halachah splits (2207 lines)
$lines = Get-Content "2-section_ii.txt"
Write-Host "Section II has $($lines.Length) lines"

# Chapter 1: lines 1-249 (Principles of Halacha)
$lines[0..248] | Set-Content -Path "section_ii/chapter_01-principles-of-halacha.txt" -Encoding UTF8
# Chapter 2: lines 250-461 (Prayer)
$lines[249..460] | Set-Content -Path "section_ii/chapter_02-prayer.txt" -Encoding UTF8
# Chapter 3: lines 462-727 (Shabbat)
$lines[461..726] | Set-Content -Path "section_ii/chapter_03-shabbat.txt" -Encoding UTF8
# Chapter 4: lines 728-817 (Festivals)
$lines[727..816] | Set-Content -Path "section_ii/chapter_04-festivals.txt" -Encoding UTF8
# Chapter 5: lines 818-861 (Kashrut)
$lines[817..860] | Set-Content -Path "section_ii/chapter_05-kashrut.txt" -Encoding UTF8
# Chapter 6: lines 862-1161 (Israel)
$lines[861..1160] | Set-Content -Path "section_ii/chapter_06-israel.txt" -Encoding UTF8
# Chapter 7: lines 1162-end (Marriage and Family)
$lines[1161..($lines.Length-1)] | Set-Content -Path "section_ii/chapter_07-marriage-and-family.txt" -Encoding UTF8
Write-Host "Section II split into 7 chapters"

# Section III-Life splits (3376 lines)
$lines = Get-Content "3-section_iii-life"
Write-Host "Section III-Life has $($lines.Length) lines"

# Chapter 1: lines 1-487 (Family)
$lines[0..486] | Set-Content -Path "section_iii_life/chapter_01-family.txt" -Encoding UTF8
# Chapter 2: lines 488-? (Marriage) - need to find chapter 3
Write-Host "Searching for chapters in Section III-Life..."

# Section III-Politics splits (1732 lines)
$lines2 = Get-Content "4-section_iii-politics"
Write-Host "Section III-Politics has $($lines2.Length) lines"

# Section IV-Ideas splits (4737 lines)
$lines3 = Get-Content "5-section_iv-ideas.txt"
Write-Host "Section IV-Ideas has $($lines3.Length) lines"

# Section V-Christianity splits (2676 lines)
$lines4 = Get-Content "6-section_v-christianity.txt"
Write-Host "Section V-Christianity has $($lines4.Length) lines"
