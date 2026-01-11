# The Torah Book of Ideas - Website Architecture

## Overview

This is a static HTML website generated from plain text source files using a PowerShell script. The site presents a multi-part religious/philosophical book with hierarchical navigation.

## Directory Structure

```
tboi/
├── generate_website.ps1     # Main generation script
├── styles.css               # All CSS styling
├── split_book/              # SOURCE: Raw text content
│   ├── part_i-Philosophy and Faith/
│   │   ├── chapter_01-god-the-song-of-god/
│   │   │   ├── section_i.txt
│   │   │   └── section_ii.txt
│   │   └── ...
│   └── ...
├── parts/                   # OUTPUT: Generated HTML
│   ├── part_i/
│   │   ├── index.html       # Part index page
│   │   ├── chapter_01/
│   │   │   ├── index.html   # Chapter index
│   │   │   ├── section_i.html
│   │   │   └── section_ii.html
│   │   └── ...
│   └── ...
├── images/                  # Book images and diagrams
├── index.html               # Home page
├── contents.html            # Table of contents
├── search.html              # Search page
├── glossary.html            # Glossary
├── bibliography.html        # Bibliography
└── *.js                     # JavaScript modules
```

## Generation Flow (`generate_website.ps1`)

### Two-Pass Architecture

**Pass 1 - Metadata Collection:**
- Iterates through all parts → chapters → sections
- Collects titles, file paths, and section counts
- Builds `$allPartsData` array with complete navigation structure
- Used for sidebar and dropdown menus

**Pass 2 - HTML Generation:**
- Creates directory structure in `/parts/`
- Generates HTML for each section using `New-SectionHTML` function
- Generates chapter index pages
- Generates part index pages
- Creates search index, sidebar content, glossary, and bibliography

### Key Variables

| Variable | Purpose |
|----------|---------|
| `$partMappings` | Maps source folders to target folders and titles |
| `$allPartsData` | Complete navigation data from Pass 1 |
| `$completeChapterList` | All chapters for current part (for dropdowns) |
| `$chapterSectionList` | Sections in current chapter |

## Source File Format

Text files support special markup:

```
[TITLE: The Paradox of Infinity]

Regular paragraph text...

[IMG: image_filename.png]

<blockquote class="fancy-quote">
Quoted text here
</blockquote>

<div class="concept-box">
<strong>Concept Title</strong>
Explanation text
</div>
```

## CSS Architecture (`styles.css`)

### Structure
1. **Root Variables** (lines 1-30) - Colors, fonts, shadows
2. **Base Styles** (lines 31-200) - Typography, layout
3. **Component Styles** (lines 200-800) - Cards, buttons, nav
4. **Responsive Queries** (lines 900-1100) - Mobile adaptations
5. **Dark Mode** (lines 2400-3100) - `body.dark-mode` overrides

### Key Components
- `.breadcrumb` - Navigation breadcrumb with dropdown menus
- `.content-card` - Main content container
- `.nav-btn` - Previous/Next navigation buttons
- `.sidebar` - Slide-out navigation for mobile
- `.concept-box`, `.fancy-quote` - Content formatting

## JavaScript Modules

| File | Purpose |
|------|---------|
| `sidebar.js` | Sidebar open/close functionality |
| `search.js` | Search index and UI |
| `glossary_tooltip.js` | Glossary term tooltips |
| `audio.js` | Audio playback features |
| `bookmarks.js` | User bookmark system |
| `breadcrumb_mobile.js` | Two-tap dropdown for touch devices |

## Navigation System

### Breadcrumb Dropdowns
- **Part dropdown**: Links to all 6 parts
- **Chapter dropdown**: Links to all chapters in current part
- **Section dropdown**: Compact grid of section numbers

### Prev/Next Navigation
- Calculated during generation
- Cross-chapter and cross-part links
- Arrows added via CSS `::before`/`::after` pseudo-elements

## Dark Mode

Toggle button in header saves preference to `localStorage`. CSS uses `body.dark-mode` selector for all overrides:
- Deep blue backgrounds (`#0a0e24`, `#121836`)
- Gold accents (`var(--accent-gold)`)
- Adjusted contrast for readability

## Build & Deploy

```powershell
# Generate website
./generate_website.ps1

# Commit and push (GitHub Pages)
git add -A && git commit -m "Update" && git push
```

Hosted on GitHub Pages at: `https://mrosten.github.io/tboi/`
