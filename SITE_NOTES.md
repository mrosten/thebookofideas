# TBOI Site Developer Guide

## Project Overview
**The Torah Book of Ideas (TBOI)** is a static HTML website generated from plaintext source files. It supports English and Hebrew (RTL) locales, featuring a shared asset architecture and offline PWA capabilities.

---

## 1. Directory Structure
The project uses a clean separation of source content, generators, and build artifacts.

```
src/tboi/
├── assets/                 # SHARED static assets
│   ├── css/                # Stylesheets (styles.css)
│   ├── js/                 # Client-side scripts (search.js, sidebar.js, etc.)
│   └── data/               # Data files (glossary_terms.json, deploy_symbol.json)
├── images/                 # SHARED images (referenced by English and Hebrew sites)
├── scripts/                # Generators and utility scripts
│   ├── generate_website.ps1 # MAIN GENERATOR
│   ├── build_one.ps1       # Incremental build script
│   └── format_glossary.py  # Helpers
├── templates/
│   └── includes/           # HTML snippets for sidebar, header, etc.
├── split_book/             # ENGLISH Source Text
│   ├── part_i/...          # Text files for chapters/sections
│   └── x-footnotes.txt     # Global footnote database
├── split_book_he/          # HEBREW Source Text
│   ├── part_i/...
│   └── x-footnotes.txt
├── he/                     # GENERATED Hebrew Site Root
└── [Root Files]            # GENERATED English Site Root
    ├── index.html
    ├── glossary.html
    ├── search.html
    ├── manifest.json
    └── service-worker.js
```

---

## 2. Core Workflows

### A. Editing Content
Content is authored in plaintext files within `split_book/` (English) or `split_book_he/` (Hebrew).
*   **Text**: Standard text. Paragraphs are auto-detected.
*   **Titles**: Use `[TITLE: My Section Title]` at the start of a file.
*   **Images**: Use `[IMAGE: filename.png]`. Files must exist in `src/tboi/images/`.
*   **Cross-Refs**: Use `[REF: part_name]` or `[REF: part_iv, ch 1, sec ii "Custom Label"]`.
*   **Footnotes**: Use `[123]` in text. Define the content in `x-footnotes.txt` as `[123] Footnote content...`.

### B. Generating the Site
The site is built using PowerShell.
**Prerequisite**: PowerShell Core (`pwsh`).

1.  **Full Rebuild (English)**:
    ```powershell
    pwsh -File scripts/generate_website.ps1
    ```
2.  **Full Rebuild (Hebrew)**:
    ```powershell
    pwsh -File scripts/generate_website.ps1 -Language he
    ```
    *This generates the site into the `he/` subdirectory.*

### C. Styling & Localization
*   **One Stylesheet**: `assets/css/styles.css` handles ALL styling.
*   **RTL Support**: We do **not** use a separate CSS file. Instead, we use `html[dir="rtl"]` selectors to override styles for Hebrew.
    ```css
    /* Example Override */
    html[dir="rtl"] .sidebar {
        border-left: none;
        border-right: 1px solid #ccc;
    }
    ```
*   **Shared Assets**: All HTML files reference assets using relative paths.
    *   Root English: `assets/css/styles.css`
    *   Root Hebrew: `../assets/css/styles.css`
    *   Deep Pages: `../../../assets/css/styles.css`
    *   **Tip**: In `generate_website.ps1`, use `${assetDepth}` to auto-inject the correct relative prefix.

---

## 3. Best Practices & Pitfalls

### Do NOT Edit Generated HTML
Files like `contents.html`, `glossary.html`, and all chapter pages are **overwritten** on every build.
*   **To change functionality**: Edit `scripts/generate_website.ps1` templates (e.g., `New-SectionHTML`).
*   **To change content**: Edit text files in `split_book/`.

### Table of Contents Logic
The "Open/Closed" state of TOC folders is defined in the `New-MainContentsHTML` function in `generate_website.ps1`. Do not try to change it in the HTML directly.

### Asset Paths in Scripts
When editing generator templates, **ALWAYS** prefix asset links with `${assetDepth}`:
*   Correct: `<link href="${assetDepth}assets/css/styles.css">`
*   Incorrect: `<link href="assets/css/styles.css">` (Will break on nested pages)

### PWA Files
`manifest.json` and `service-worker.js` reside in the **root**.
*   English site references: `'service-worker.js'`
*   Hebrew site references: `'../service-worker.js'`

---

## 4. Maintenance
*   **Deploy Symbol**: `deploy_symbol.json` is updated by CI scripts to track build versions.
*   **Linting**: Ignore `destDir` warnings in scripts if they are false positives from legacy code cleanups.
*   **Search Index**: `search_index.json` is generated automatically. If search results are stale, rebuild the site.


## 5. Current Status (Jan 12, 2026)
*   **Issues**:
    *   **Navigation**: Reported broken on some pages. Needs investigation.
    *   **Restructuring**: Proposal to rename `split_book` -> `content/` and move English site to `en/` is **PAUSED**. See proposals below.

### Translation Progress (Jan 12, 2026)
| Part | English Files | Hebrew Files | Status |
| :--- | :--- | :--- | :--- |
| **Part I** (Philosophy) | 36 | 35 | **Almost Done** (~1 file missing) |
| **Part II** (Halachah) | 30 | 12 | **~40% Complete** |
| **Part III** (Life) | 26 | 12 | **~46% Complete** |
| **Part IV** (Politics) | 9 | 0 | **Not Started** |
| **Part V** (Ideas) | 17 | 0 | **Not Started** |
| **Part VI** (Christianity) | 12 | 0 | **Not Started** |

---

## 6. Restructuring Proposals (Pending Decision)
The goal is to reduce friction in the "split book" workflow and balance the directory structure.

### Option A: "HTML First" (Eject the Generator)
**The "What You See Is What You Edit" Approach.**
*   **Concept**: Delete `split_book` entirely. Generated HTML files become the source.
*   **Workflow**: Edit HTML files directly.
*   **Automation**: Replace `generate_website.ps1` with a lighter script for shared layout (sidebar/header) updates only.
*   **Pros**: Zero friction for content edits.
*   **Cons**: Editing raw HTML.

### Option B: Rename & Modernize
**Cleaner structure, same workflow.**
*   **Concept**: Rename `split_book` → `content/en`, `split_book_he` → `content/he`.
*   **Workflow**: Edit text files -> Rebuild site.
*   **Pros**: Logical directory structure.
*   **Cons**: Retains the double-editing friction.

### Option C: The "Hybrid" (Markdown)
**Standardize the source.**
*   **Concept**: Convert text files to standard Markdown (`.md`) in `content/`.
*   **Workflow**: Edit Markdown -> Rebuild site.
*   **Pros**: Industry standard, easier editing than raw text.
*   **Cons**: Still requires a build step.

