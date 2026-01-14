# TBOI Website Issues

## Fixed Issues ✅

### 1. Language Toggle 404 Error — FIXED ✅
**Location:** All chapters (system-wide)
**Problem:** Clicking the language icon led to "Page Not Found"
**Root Cause:** Hebrew files used Roman numerals (`section_i.md`) while English used Arabic (`section_01.md`)
**Fix Applied:** Renamed 68 Hebrew files across all parts to Arabic numerals to match English
**Date Fixed:** 2026-01-13

### 2. Language Icon Dark Mode Styling — NEEDS CSS UPDATE
**Location:** Header language toggle button
**Problem:** Icon looks out of place in dark mode
**Action Needed:** Update CSS in `styles.css` to add `.dark-mode .lang-toggle` styling
**Status:** Pending (low priority, cosmetic)

---

### 3. Dark Mode Readability - Ch01 Sec 05
**Location:** `part_i_philosophy/chapter_01/section_05.md`
**Problem:** User reported "certain text from the activity become unreadable" in dark mode.
**Action Needed:** Audit the CSS for the interactive element in this section and add dark mode overrides.
**Status:** Pending

---
*Last Updated: 2026-01-13*
