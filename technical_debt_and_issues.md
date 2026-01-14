# Technical Debt & Issue Log

## 🚨 Critical Regressions
*None active.*

---

## 🛠️ Fixed Issues
### 1. Breadcrumb Navigation Failure
**Status:** ✅ FIXED (Jan 14, 2026)
**Issue:** Breadcrumbs were missing structure and dropdown functionality.
**Fix:** Rewrote `Get-BreadcrumbHTML` in `build.ps1` to explicitly handle dropdown generation and add proper CSS classes. Validated in Chrome.

### 2. Broken Links in Table of Contents
**Status:** ✅ FIXED (Jan 14, 2026)
**Issue:** `contents.html` pointed to stale `section_i.html` files instead of `section_01.html`.
**Fix:** Scripted update of `contents.md` links and rebuilt. Deleted stale files.

### 3. Service Worker Pathing
**Status:** ✅ FIXED

**Issue:** `service-worker.js` was caching path-relative assets (`styles.css`) from root, causing 404s and installation failure.
**Fix:** Updated paths to `assets/css/styles.css`, `assets/js/...`.

### 2. Dark Mode Visibility
**Status:** ✅ FIXED
**Issue:**
- "Sephirot Diagram" (Part I Ch 1 Sec 5) was unreadable in dark mode.
- Language Toggle icon visibility poor.
**Fix:** Added specific `.dark-mode` CSS overrides.

### 3. Missing Favicon
**Status:** ✅ FIXED
**Issue:** Browser tab lacked icon.
**Fix:** Added `<link rel="icon">` to `layout.html`.

---

## ⚠️ Architectural Risks
### 1. Build Script Complexity (`build.ps1`)
The `build.ps1` script has grown to handle:
- Markdown parsing
- Frontmatter extraction
- Template injection
- Sitemap generation
- **Breadcrumb logic**
- Asset path resolution
**Risk:** Logic is brittle. Changing one variable (like `$BaseUrl`) or directory structure (`en/` vs `split_book/`) ripples through the entire generation process, often breaking path-dependent features like Breadcrumbs.

### 2. Hardcoded Paths in Content
Some markdown files may still contain relative image paths (`../../images`) that break when files are moved or when the build nesting level changes.

### 3. Mixed Content State
`part_iii_life` contains a mix of "Enhanced" (HTML-heavy) and "Raw" markdown. This inconsistency makes global styling changes risky.

---

## 📋 Next Steps for Stability
1.  **Freeze Build Logic:** Stop adding features to `build.ps1`. Only fix bugs.
2.  **Unit Tests:** (Recommended) Add a test script to grep generated HTML for key elements (e.g., `<nav class="breadcrumb">`) to catch regressions before deployment.
3.  **Standardize Content:** Finish "Premium Visuals" enhancement for Part III to remove the "Mixed State" risk.
