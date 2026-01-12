// Language Toggle Logic
document.addEventListener('DOMContentLoaded', () => {
    const langToggle = document.getElementById('lang-toggle');
    if (!langToggle) return;

    langToggle.addEventListener('click', () => {
        const currentPath = window.location.pathname;

        // Robust switching using 'tboi' folder as anchor
        // This works for both local file system (file:///C:/.../src/tboi/...)
        // and web server paths (/tboi/...)

        let newPath;

        if (currentPath.includes('/tboi/he/')) {
            // Hebrew -> English: Replace /he/ with /en/
            newPath = currentPath.replace('/tboi/he/', '/tboi/en/');
        } else if (currentPath.includes('/tboi/en/')) {
            // English -> Hebrew: Replace /en/ with /he/
            newPath = currentPath.replace('/tboi/en/', '/tboi/he/');
        } else {
            // Fallback for non-standard structures or root
            // If we are at root /tboi/index.html, do nothing or go to default?
            // Usually this script runs on internal pages.
            // Let's try to detect generic /he/ or /en/ segments
            if (currentPath.match(/\/he\//) || currentPath.endsWith('/he')) {
                newPath = currentPath.replace(/\/he(\/|$)/, '/en$1');
            } else if (currentPath.match(/\/en\//) || currentPath.endsWith('/en')) {
                newPath = currentPath.replace(/\/en(\/|$)/, '/he$1');
            } else {
                // Try to look for tboi root and default to he from en-assumed root?
                // No, if we are in a structure without 'en' or 'he', we can't safely switch.
                console.warn("Language toggle: Could not determine current language context.");
                return;
            }
        }

        // Navigate
        window.location.href = newPath;
    });

    // Set Button Text/State based on current URL
    const langText = langToggle.querySelector('.lang-text');
    if (langText) {
        if (window.location.pathname.includes('/he/')) {
            langText.textContent = "EN"; // Button shows target language
            langToggle.setAttribute('aria-label', 'Switch to English');
        } else {
            langText.textContent = "עב"; // Hebrew abbreviation
            langToggle.setAttribute('aria-label', 'Switch to Hebrew');
        }
    }
});
