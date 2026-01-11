// Language Toggle Logic
document.addEventListener('DOMContentLoaded', () => {
    const langToggle = document.getElementById('lang-toggle');
    if (!langToggle) return;

    langToggle.addEventListener('click', () => {
        const currentPath = window.location.pathname;
        const currentOrigin = window.location.origin;

        // Check if we are in Hebrew context (path contains '/he/')
        // Note: This relies on the directory structure 'src/tboi/he'
        // For local development, paths might vary, but relative structure is key.

        let newPath;

        // If already in Hebrew path, remove the leading '/he' segment
        if (currentPath.startsWith('/he/') || currentPath === '/he' || currentPath === '/he/') {
            newPath = currentPath.replace(/^\/he(\/|$)/, '/');
        } else if (currentPath.includes('/tboi/he/')) {
            // handle hosted under /tboi/he/
            newPath = currentPath.replace('/tboi/he/', '/tboi/');
        } else if (currentPath.includes('/he/')) {
            // general case: remove any '/he/' segment
            newPath = currentPath.replace('/he/', '/');
        } else {
            // Not in Hebrew — construct Hebrew path by inserting '/he' at site root
            // If the site is hosted under a base folder like '/tboi/', preserve it
            const match = currentPath.match(/^\/(?<base>[^\/]+)(?<rest>\/.*|$)/);
            if (match && match.groups && match.groups.base === 'tboi') {
                // insert after /tboi
                newPath = currentPath.replace('/tboi/', '/tboi/he/');
            } else {
                // generic: prefix with /he
                newPath = '/he' + currentPath;
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
