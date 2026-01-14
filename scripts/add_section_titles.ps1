# Add Section Titles to Chapter 1
$sectionsPath = "c:\myantigravity\cantorwilliam\src\tboi_backup_state\content\en\parts\part_v_ideas\chapter_01\"

# Map of section numbers to titles
$titles = @{
    "section_01" = "The Gematria of Reality"
    "section_02" = "The General Theory of Sephirot"
    "section_03" = "The Fluid Dynamics of the Commandment"
    "section_04" = "The Infinite Singularity"
    "section_05" = "The Divine Current-Bearing Conductor"
    "section_06" = "The Wave Function of the Soul"
    "section_07" = "The Physics of Emanation"
    "section_08" = "The Physics of Understanding (Binah)"
    "section_09" = "The Physics of Limitations"
    "section_10" = "Harmonics of Creation"
    "section_11" = "Spiritual Probability & Red Shift"
    "section_12" = "The Taylor Series of Marriage"
    "section_13" = "Linear Independence of Torah"
    "section_14" = "Divine Eigenvalues"
    "section_15" = "The Cubical Matrix of Split Sea"
    "section_16" = "The Metrics of God"
    "section_17" = "The Strange Loop of Worlds"
    "section_18" = "The Transpose of the Soul"
    "section_19" = "Recursion of the Void"
    "section_20" = "The Physics of Palaces"
}

foreach ($key in $titles.Keys) {
    $filePath = Join-Path $sectionsPath "$key.md"
    
    if (Test-Path $filePath) {
        Write-Host "Processing $key..."
        
        $content = Get-Content $filePath -Raw
        $lines = Get-Content $filePath
        
        # Check if title already exists
        if ($content -match '<h3 class="section-title">') {
            Write-Host "  Title already exists, skipping..."
            continue
        }
        
        # Find line 11 (after ---) and inject title
        $newLines = @()
        for ($i = 0; $i -lt $lines.Count; $i++) {
            $newLines += $lines[$i]
            
            # After line 10 (index 9), add the title
            if ($i -eq 10) {
                $newLines += ""
                $newLines += "<h3 class=`"section-title`">$($titles[$key])</h3>"
            }
        }
        
        Set-Content -Path $filePath -Value $newLines -Force
        Write-Host "  Added title: $($titles[$key])"
    }
}

Write-Host "`nDone!"
