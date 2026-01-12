# Automated Hebrew Translation Script for Torah Book of Ideas
# Uses Google Gemini API to translate all sections while preserving HTML structure

param(
    [switch]$DryRun,
    [switch]$Force
)

$ErrorActionPreference = "Stop"

# Configuration
$englishRoot = ".\split_book"
$hebrewRoot = ".\split_book_he"
$logFile = ".\translation_log_$(Get-Date -Format 'yyyyMMdd_HHmmss').txt"
$apiEndpoint = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash-exp:generateContent"
$apiKey = $env:GEMINI_API_KEY

# Check API key
if ([string]::IsNullOrWhiteSpace($apiKey)) {
    Write-Error "GEMINI_API_KEY environment variable not set. Please run: `$env:GEMINI_API_KEY = 'your-key'"
    exit 1
}

# Translation prompt template
$translationPrompt = @"
You are translating a philosophical and religious text from English to Hebrew. This is from "The Torah Book of Ideas."

CRITICAL INSTRUCTIONS:
1. Translate ALL English text to Hebrew
2. PRESERVE all HTML tags exactly as they are (do not translate tag names, class names, IDs, or attributes)
3. PRESERVE all JavaScript code exactly as is
4. Keep Torah/Hebrew terms authentic (e.g., "Sephirot" → "ספירות", "Kabbalah" → "קבלה", "Torah" → "תורה")
5. Maintain the exact same structure and formatting
6. Keep [TITLE: ...] markers intact, only translate the text after the colon
7. Do NOT add any explanations or notes - only output the translated content

SPECIAL TERMS TO HANDLE:
- Rabbi/Rav names: Keep transliterated or use Hebrew (e.g., "Rabbi Nachman" → "רבי נחמן")
- "Baal Shem Tov" → "בעל שם טוב"
- "Arizal" → "האר"י"
- "Rambam" → "הרמב"ם"  
- "Ramchal" → "הרמח"ל"
- Sephirot names: Use Hebrew (Chesed/חסד, Gevurah/גבורה, etc.)

Now translate this text to Hebrew:

{TEXT}
"@

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $logMessage = "[$timestamp] [$Level] $Message"
    Write-Host $logMessage
    Add-Content -Path $logFile -Value $logMessage
}

function Invoke-GeminiTranslation {
    param([string]$Text)
    
    $prompt = $translationPrompt -replace '\{TEXT\}', $Text
    
    $body = @{
        contents         = @(
            @{
                parts = @(
                    @{
                        text = $prompt
                    }
                )
            }
        )
        generationConfig = @{
            temperature     = 0.3
            maxOutputTokens = 8192
        }
    } | ConvertTo-Json -Depth 10
    
    try {
        $response = Invoke-RestMethod -Uri "$apiEndpoint`?key=$apiKey" -Method Post -Body $body -ContentType "application/json; charset=utf-8"
        
        if ($response.candidates -and $response.candidates[0].content.parts) {
            return $response.candidates[0].content.parts[0].text
        }
        else {
            throw "Unexpected API response format"
        }
    }
    catch {
        Write-Log "API Error: $_" "ERROR"
        throw
    }
}

function Get-SectionFiles {
    $sections = @()
    
    Get-ChildItem -Path $englishRoot -Directory | ForEach-Object {
        $part = $_
        Get-ChildItem -Path $part.FullName -Directory | ForEach-Object {
            $chapter = $_
            Get-ChildItem -Path $chapter.FullName -Filter "section_*.txt" | ForEach-Object {
                $sections += @{
                    Part        = $part.Name
                    Chapter     = $chapter.Name
                    Section     = $_.Name
                    EnglishPath = $_.FullName
                    HebrewPath  = $_.FullName -replace [regex]::Escape($englishRoot), $hebrewRoot
                }
            }
        }
    }
    
    return $sections
}

# Main execution
Write-Log "=== Starting Automated Translation ===" "INFO"
Write-Log "English Root: $englishRoot"
Write-Log "Hebrew Root: $hebrewRoot"
Write-Log "Dry Run: $DryRun"
Write-Log "API Key set: $(if($apiKey) {'Yes'} else {'No'})"

# Get all section files
$allSections = Get-SectionFiles
Write-Log "Found $($allSections.Count) total sections"

# Filter to only untranslated sections (or all if Force)
$sectionsToTranslate = $allSections | Where-Object {
    $Force -or -not (Test-Path $_.HebrewPath)
}

Write-Log "Sections to translate: $($sectionsToTranslate.Count)"

if ($sectionsToTranslate.Count -eq 0) {
    Write-Log "No sections need translation! Use -Force to retranslate all." "INFO"
    exit 0
}

# Translate each section
$translated = 0
$failed = 0

foreach ($section in $sectionsToTranslate) {
    $sectionName = "$($section.Part)/$($section.Chapter)/$($section.Section)"
    Write-Log "Translating: $sectionName"
    
    try {
        # Read English content
        $englishContent = Get-Content -Path $section.EnglishPath -Raw -Encoding UTF8
        
        if ($DryRun) {
            Write-Log "  [DRY RUN] Would translate $($englishContent.Length) characters" "INFO"
            $translated++
            continue
        }
        
        # Translate via Gemini
        Write-Log "  Calling Gemini API..."
        $hebrewContent = Invoke-GeminiTranslation -Text $englishContent
        
        # Ensure directory exists
        $hebrewDir = Split-Path $section.HebrewPath -Parent
        if (-not (Test-Path $hebrewDir)) {
            New-Item -ItemType Directory -Path $hebrewDir -Force | Out-Null
        }
        
        # Write Hebrew content
        [System.IO.File]::WriteAllText($section.HebrewPath, $hebrewContent, [System.Text.Encoding]::UTF8)
        Write-Log "  ✓ Translated successfully ($($hebrewContent.Length) chars)" "SUCCESS"
        
        $translated++
        
        # Rate limiting - wait 2 seconds between requests
        Start-Sleep -Seconds 2
    }
    catch {
        Write-Log "  ✗ Failed: $_" "ERROR"
        $failed++
        
        # Continue with next section instead of stopping
        continue
    }
}

Write-Log ""
Write-Log "=== Translation Complete ===" "INFO"
Write-Log "Successfully translated: $translated"
Write-Log "Failed: $failed"
Write-Log "Log file: $logFile"

if ($failed -gt 0) {
    Write-Log "Some translations failed. Check the log for details." "WARNING"
}

exit 0
