param(
    [ValidateSet('en', 'he')]
    [string]$Language = 'en',          # language to build
    [Parameter(Mandatory = $true)]
    [string]$FilePath                  # path **relative** to src\tboi (e.g. he/parts/part_i/chapter_09/section_ii.html)
)

$ErrorActionPreference = 'Stop'

# Resolve absolute paths
$root = Split-Path -Parent $MyInvocation.MyCommand.Path   # src\tboi
$srcRoot = Join-Path $root ($Language -eq 'he' ? 'split_book_he' : 'split_book')
$outputDir = Join-Path $root $Language

# Ensure output folder exists
if (-not (Test-Path $outputDir)) {
    New-Item -ItemType Directory -Path $outputDir -Force | Out-Null
}

# Add helper function for localization if not present in scope
# Simple dictionary for now or just placeholders as we are doing single file replacement
# For full fidelity we should probably dot-source generate_website.ps1 or duplicate logic.
# Since this is a "quick helper", we will do a simplified conversion that matches the main script's regexes for images/layout.

# BUT, the main script uses a template system. Simplistic replacement might fail to produce the full HTML structure (sidebar, header, etc).
# The user wants "quick update". The best way is to actually leverage the main script's logic if possible, OR
# replicate the *exact* template wrapping.
# Given the complexity of the sidebar and header seen in the HTML files, a simple "Convert-To-HTML" that just dumps content won't work.
# It needs to wrap it in the HTML skeleton.

# Let's try to be smart. The main generate_website.ps1 script has all the logic.
# Maybe we can just dot-source it and call a function?
# Checking generate_website.ps1 content would be wise, but I can't see it all right now.
# However, the previous "proposed" script was very simple and claimed:
# "$html = $content -replace ... Set-Content ..."
# That would OVERWRITE the full HTML file with just the body content, losing the navigation/sidebar!
# THAT WOULD BE BAD.

# BETTER APPROACH for "Quick Rebuild":
# 1. Read the EXISTING HTML file.
# 2. Read the SOURCE text file.
# 3. Convert source text to HTML fragment.
# 4. Inject that fragment into the "Body" (or main content area) of the existing HTML file.
#    OR just run the full generate_website.ps1 but filtered?
#    The `generate_website.ps1` doesn't seem to have a filter.
#    
#    Let's look at `generate_website.ps1` to see if we can easily add a filter or call a function.
#    I'll start by reading the main script.
