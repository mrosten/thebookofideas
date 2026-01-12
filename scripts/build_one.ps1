param(
    [ValidateSet('en', 'he')]
    [string]$Language = 'he',          # Default to Hebrew for this task
    [Parameter(Mandatory = $true)]
    [string]$FilePath                  # Relative path to HTML file, e.g. parts/part_i/chapter_09/section_ii.html
)

$ErrorActionPreference = 'Stop'
Write-Host "Starting Quick Build for $FilePath ($Language)..."

# 1. Setup Paths
$rootDir = "c:\myantigravity\cantorwilliam\src\tboi"

# Handle language-specific output paths
# Hebrew goes to src\tboi\he\...
# English goes to src\tboi\... (Root)
if ($Language -eq 'he') {
    $destFile = Join-Path $rootDir "he\$FilePath"
    $splitBookDir = Join-Path $rootDir "split_book_he"
}
else {
    $destFile = Join-Path $rootDir $FilePath
    $splitBookDir = Join-Path $rootDir "split_book"
}

$destDir = Split-Path $destFile -Parent

# Source text file logic
$filename = Split-Path $FilePath -LeafBase
$chapterFolder = (Split-Path $FilePath -Parent) | Split-Path -Leaf

# Find the specific text file
$srcFileObj = Get-ChildItem -Path $splitBookDir -Recurse -Filter "$filename.txt" | Where-Object { $_.Directory.Name -like "*$chapterFolder*" } | Select-Object -First 1

if (-not $srcFileObj) {
    Write-Error "Could not find source text file for $filename in $splitBookDir matching chapter $chapterFolder"
    exit 1
}
$srcFile = $srcFileObj.FullName
Write-Host "Found source: $srcFile"

# 2. Read Source Content and Process
$content = Get-Content -Path $srcFile -Raw -Encoding UTF8
Write-Host "Read $($content.Length) chars from $srcFile"

# --- Convert content to HTML Fragment ---
# Handle Title
$content = $content -replace '\[TITLE:\s*(.*?)\]', '<h1>$1</h1>'

# Handle Images
# Use variable depth to point to SHARED images for both En and He.
# En: ../../../images
# He: ../../../../images
if ($Language -eq 'he') {
    $depth = "../../../.."
}
else {
    $depth = "../../.."
}

$content = $content -replace '\[IMAGE:\s*(.*?)\]', "<div class='image-container'><img src='$depth/images/`$1' alt='Book Image' class='book-image'></div>"
Write-Host "Content length after processing: $($content.Length) chars"

# Simple formatting
$content = $content -replace '\*\*(.*?)\*\*', '<strong>$1</strong>'
$content = $content -replace '\*(.*?)\*', '<em>$1</em>'

# 3. Inject into Existing HTML
if (-not (Test-Path $destFile)) {
    Write-Error "Destination HTML file not found: $destFile. Run full build first to generate key structure."
    exit 1
}

$html = Get-Content -Path $destFile -Raw -Encoding UTF8

# Regex to find the content area
$mainStartIdx = $html.IndexOf("<main")
if ($mainStartIdx -eq -1) {
    Write-Error "Could not find <main> tag in $destFile"
    exit 1
}

$mainTagEndIdx = $html.IndexOf(">", $mainStartIdx)
if ($mainTagEndIdx -eq -1) {
    Write-Error "Could not find closing bracket of <main> tag"
    exit 1
}

# Extract parts
$pageNavIdx = $html.IndexOf('<div class="page-nav">')
if ($pageNavIdx -eq -1) {
    $pageNavIdx = $html.IndexOf("<div class='page-nav'>")
}

if ($pageNavIdx -eq -1) {
    Write-Error "Could not find <div class='page-nav'> (checked single/double quotes) in $destFile"
    exit 1
}

# Extract parts
$preMain = $html.Substring(0, $mainTagEndIdx + 1)
$postContent = $html.Substring($pageNavIdx)

# Construct new HTML
$newHtml = $preMain + "`n" + $content + "`n" + $postContent

Set-Content -Path $destFile -Value $newHtml -Encoding UTF8
Write-Host "Updated HTML content in $destFile"

Write-Host "Done. (Assets are shared, no copy needed)"
