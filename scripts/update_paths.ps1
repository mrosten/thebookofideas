$files = Get-ChildItem -Path "src/tboi/en" -Recurse -Filter *.html

foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw
    $original = $content
    
    # Calculate Depth relative to src/tboi/en
    # en/index.html -> Depth 0
    # en/parts/part_i/chapter_01/section_i.html -> Depth 3
    
    # We want to link to src/tboi/assets/
    # From en/ (Depth 0): Need ../assets/
    # From Depth 3: Need ../../../../assets/ (4 dots)
    # General Rule: dots = "../" * (Depth + 1)
    
    $relativePath = $file.FullName.Substring((Join-Path (Get-Location) "src/tboi/en").Length).Trim('\', '/')
    if ($relativePath -eq "") { $depth = 0 } 
    else { $depth = ($relativePath.Split('\')).Count - 1 }
    
    if ($depth -lt 0) { $depth = 0 }
    
    $dots = "../" * ($depth + 1)
    
    # Fix CSS Links (flexible match for styles.css)
    # Match href=".../styles.css" or href=".../assets/css/styles.css"
    # Capture nothing, just replace the whole path to be safe/canonical
    # But wait, original might be `../../../styles.css` or `../../../assets/css/styles.css`
    # We want to normalize to `$dots + "assets/css/styles.css"`
    
    $content = $content -replace 'href="[^"]*?styles\.css"', "href=`"${dots}assets/css/styles.css`""
    
    # Fix JS Links (flexible match for scripts)
    $content = $content -replace 'src="[^"]*?sidebar\.js"', "src=`"${dots}assets/js/sidebar.js`""
    $content = $content -replace 'src="[^"]*?search\.js"', "src=`"${dots}assets/js/search.js`""
    $content = $content -replace 'src="[^"]*?language_toggle\.js"', "src=`"${dots}assets/js/language_toggle.js`""
    $content = $content -replace 'src="[^"]*?glossary_tooltip\.js"', "src=`"${dots}assets/js/glossary_tooltip.js`""
    $content = $content -replace 'src="[^"]*?audio\.js"', "src=`"${dots}assets/js/audio.js`""
    $content = $content -replace 'src="[^"]*?bookmarks\.js"', "src=`"${dots}assets/js/bookmarks.js`""
    $content = $content -replace 'src="[^"]*?breadcrumb_mobile\.js"', "src=`"${dots}assets/js/breadcrumb_mobile.js`""
    
    # Fix Manifest
    $content = $content -replace 'href="[^"]*?manifest\.json"', "href=`"${dots}manifest.json`""
    
    # Fix Service Worker Registration
    $content = $content -replace "'[^']*?service-worker\.js'", "'${dots}service-worker.js'"

    # Fix Images (src=".../images/...")
    # Be careful not to double replace if path is already good
    # We replace any sequence of `../` followed by `images/` with the canonical path
    $content = $content -replace 'src="(?:\.\./)*images/', "src=`"${dots}images/"
    
    if ($content -ne $original) {
        Set-Content -Path $file.FullName -Value $content -Encoding UTF8
        Write-Host "Updated: $($file.Name)"
    }
}
Write-Host "Done updating paths."
