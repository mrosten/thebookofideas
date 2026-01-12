param (
    [string]$TargetDir = "src/tboi", # Default to both en and he
    [string]$Section = "All" # All, Sidebar, Header, Nav, Footer, Head
)

# Define Master Templates (You can edit these strings or move them to external files later)
# Ideally, read from external files in src/tboi/templates/includes/

$Languages = @("en", "he")

function Get-MasterContent($lang, $part) {
    $path = "src/tboi/templates/includes/${part}_${lang}.html"
    if (Test-Path $path) {
        return Get-Content $path -Raw
    }
    return $null
}

function Update-FileSection($content, $startMarker, $endMarker, $newContent) {
    if ([string]::IsNullOrWhiteSpace($newContent)) { return $content }
    
    $pattern = "(?s)($startMarker)(.*?)($endMarker)"
    if ($content -match $pattern) {
        return $content -replace $pattern, "${1}`n${newContent}`n${3}"
    }
    return $content
}

# Main Loop
foreach ($lang in $Languages) {
    $searchpath = Join-Path $TargetDir $lang
    if (-not (Test-Path $searchpath)) { continue }

    Write-Host "Processing Language: $lang..." -ForegroundColor Cyan

    # Load Masters for this language
    # NOTE: Masters are assumed to be written with paths relative to ROOT (e.g. href="src/tboi/parts/...") 
    # OR relative to a standard depth (e.g. depth 3: ../../../).
    # To be safe/standard, let's assume Masters use standard Depth 3 (../../../) as that's what we extracted.
    
    $MasterSidebar = Get-MasterContent $lang "sidebar"
    $MasterHeader = Get-MasterContent $lang "header"
    $MasterFooter = Get-MasterContent $lang "footer"

    $files = Get-ChildItem -Path $searchpath -Recurse -Filter *.html

    foreach ($file in $files) {
        $content = Get-Content $file.FullName -Raw
        $original = $content
        $modified = $content

        # Calculate Depth of this file relative to language root
        # e.g. en/parts/part_i/chapter_01/section_iii.html -> Depth 3 (parts/part_i/chapter_01)
        # en/index.html -> Depth 0
        
        $relativePath = $file.FullName.Substring($searchpath.Length).Trim('\', '/')
        $segments = $relativePath.Split('\')
        $depth = $segments.Count - 1 # Depth 0 for index.html at root of lang dir
        if ($depth -lt 0) { $depth = 0 }

        # Function to adjust paths in content
        # We assume Master Content uses "../../../" (Depth 3) as base.
        $AdjustPaths = {
            param($text, $fileDepth)
            # Master is Depth 3. Target is $fileDepth.
            # Difference: $diff = $fileDepth - 3
            # If diff > 0, we need to ADD "../"
            # If diff < 0, we need to REMOVE "../"
            
            # Actually, simpler: RegEx replace `(\.\./)+` with the correct number of `../` for this file.
            # "Correct number" = $fileDepth + 1 (to get out of lang dir) ??
            # Wait, src/tboi/he/parts/part_i/chapter_01/file.html
            # Link to src/tboi/assets/css/styles.css
            # Depth 3: ../../../../assets (4 dots?)
            # Let's count:
            # chapter_01 -> part_i (..)
            # part_i -> parts (..)
            # parts -> he (..)
            # he -> src/tboi (..) -> ../../../../assets.
            
            # The generated files use `../../../../` for assets.
            # So Depth 3 corresponds to `../../../../` (4 sets of dots).
            # So `NumDots = Depth + 1`.
            
            $dots = "../" * ($fileDepth + 1)
            
            # Replace existing relative paths (assumed to be ../../...)
            # We match `href="((?:\.\./)+)` and replace with `href="$dots`
            $text = $text -replace 'href="((?:\.\./)+)', "href=`"$dots"
            $text = $text -replace 'src="((?:\.\./)+)', "src=`"$dots"
            return $text
        }

        # Sidebar Update
        if ($Section -eq "All" -or $Section -eq "Sidebar") {
            $thisSidebar = & $AdjustPaths -text $MasterSidebar -fileDepth $depth
            $modified = Update-FileSection $modified "<!-- START SIDEBAR -->" "<!-- END SIDEBAR -->" $thisSidebar
        }

        # Footer Update
        if ($Section -eq "All" -or $Section -eq "Footer") {
            $thisFooter = & $AdjustPaths -text $MasterFooter -fileDepth $depth
            $modified = Update-FileSection $modified "<!-- START FOOTER -->" "<!-- END FOOTER -->" $thisFooter
        }

        if ($modified -ne $original) {
            Set-Content -Path $file.FullName -Value $modified -Encoding UTF8
            Write-Host "Updated: $($file.Name)"
        }
    }
}

Write-Host "Layout Update Complete."
