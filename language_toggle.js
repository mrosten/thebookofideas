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

        // Simple heuristic: check for '/he/' segment
        if (currentPath.includes('/he/')) {
            // Switch to English: Remove '/he/'
            // Example: /tboi/he/index.html -> /tboi/index.html
            newPath = currentPath.replace('/he/', '/');
        } else {
            // Switch to Hebrew: Insert '/he/'
            // We need to know where to insert it. usually after the base project folder.
            // Assuming structure: .../tboi/index.html -> .../tboi/he/index.html

            // If we are at root index.html
            if (currentPath.endsWith('index.html') || currentPath.endsWith('/')) {
                // Find the last slash to insert 'he/'
                const parts = currentPath.split('/');
                const last = parts.pop(); // file or empty
                newPath = parts.join('/') + '/he/' + last;
            } else {
                // If deep link: .../parts/part_i/...
                // Need to insert 'he/' before 'parts' or after 'tboi'
                // This is tricky with varying base URLs. 

                // Robust relative switch:
                // If EN: go to 'he/' relative to root? No, relative links break.

                // Let's rely on string replacement for specific known structure.
                // Improve regex to look for '/tboi/' if present
                if (currentPath.includes('/tboi/')) {
                    newPath = currentPath.replace('/tboi/', '/tboi/he/');
                } else {
                    // Fallback for simple server serving from root
                    // /index.html -> /he/index.html
                    newPath = '/he' + currentPath;
                }
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
