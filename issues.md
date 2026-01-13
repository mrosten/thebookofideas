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

*Last Updated: 2026-01-13*
