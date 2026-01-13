# clean_content.ps1
# Cleans up artifacts in Markdown files in src/tboi/content

param (
    [string]$ContentDir = "$PSScriptRoot/../content",
    [switch]$Fix
)

$files = Get-ChildItem -Path $ContentDir -Recurse -Filter *.md

foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw
    $originalContent = $content

    # 1. Remove recursive "Section Nav" comments
    # The migration seems to have pasted the full HTML including comments multiple times
    $content = $content -replace "(?ms)<!-- Section Nav -->\s*</div>\s*<!-- Section Nav -->", ""
    $content = $content -replace "<!-- Section Nav -->", ""

    # 2. Fix Broken Paragraph wrapping around divs
    # Regex look for <p> immediately followed by closing div, or closing div followed by </p>
    
    # Fix <p></div></p> pattern
    $content = $content -replace "<p>\s*</div>\s*</p>", "</div>"
    
    # Fix <p></div> pattern (start of p, immediate close div)
    $content = $content -replace "<p>\s*</div>", "</div>"

    # Fix </div></p> pattern
    $content = $content -replace "</div>\s*</p>", "</div>"

    # Fix specific massive close block seen in section_i.md: <p></div> </div> </div></p>
    $content = $content -replace "<p>\s*(</div>\s*)+\s*</p>", '$1'

    # 3. Fix empty paragraphs
    $content = $content -replace "<p>\s*</p>", ""

    # 4. Collapse multiple newlines
    $content = $content -replace "(\r?\n){3,}", "`n`n"

    if ($content -ne $originalContent) {
        Write-Host "Detected changes in: $($file.Name)" -ForegroundColor Yellow
        if ($Fix) {
            Set-Content -Path $file.FullName -Value $content -Encoding UTF8
            Write-Host "  -> FIXED" -ForegroundColor Green
        }
        else {
            # Show diff preview (simple)
            Write-Host "  -> Run with -Fix to apply." -ForegroundColor DarkGray
        }
    }
}
