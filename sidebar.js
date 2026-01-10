// Sidebar Navigation Logic
document.addEventListener('DOMContentLoaded', () => {
    const sidebarContainer = document.getElementById('sidebar-container');
    const overlay = document.getElementById('sidebar-overlay');
    const toggleBtn = document.getElementById('sidebar-toggle');

    if (!sidebarContainer || !overlay || !toggleBtn) {
        console.error('Sidebar elements not found');
        return;
    }

    // Determine path to root relative to current page
    let rootPath = '';
    const pathname = window.location.pathname.replace(/\\/g, '/'); // Normalize Windows paths
    const pathSegments = pathname.split('/').filter(s => s.length > 0);

    // Count depth from parts folder
    const partsIndex = pathSegments.indexOf('parts');
    if (partsIndex !== -1) {
        const depth = pathSegments.length - partsIndex - 1;
        rootPath = '../'.repeat(depth);
    }

    console.log('Sidebar: rootPath =', rootPath);

    // Setup toggle button IMMEDIATELY (don't wait for fetch)
    toggleBtn.addEventListener('click', () => {
        console.log('Sidebar toggle clicked');
        sidebarContainer.classList.add('open');
        overlay.classList.add('active');
        document.body.style.overflow = 'hidden';
    });

    // Close sidebar
    function closeSidebar() {
        sidebarContainer.classList.remove('open');
        overlay.classList.remove('active');
        document.body.style.overflow = '';
    }

    overlay.addEventListener('click', closeSidebar);

    // Fetch and inject sidebar content
    fetch(rootPath + 'sidebar_content.html')
        .then(response => {
            if (!response.ok) throw new Error(`Sidebar not found: ${response.status}`);
            return response.text();
        })
        .then(html => {
            sidebarContainer.innerHTML = html;

            // Setup close button
            const closeBtn = document.getElementById('close-sidebar');
            if (closeBtn) {
                closeBtn.addEventListener('click', closeSidebar);
            }

            // Fix links
            const links = sidebarContainer.querySelectorAll('a');
            links.forEach(link => {
                const rawPath = link.getAttribute('data-path');
                if (rawPath) {
                    link.href = rootPath + rawPath;
                }
                // Close on link click
                link.addEventListener('click', closeSidebar);
            });

            console.log('Sidebar loaded successfully');
        })
        .catch(err => {
            console.error('Error loading sidebar:', err);
            sidebarContainer.innerHTML = '<div class="sidebar-header"><h3>Navigation</h3></div><div class="sidebar-scroll"><p style="padding:1rem;color:#999;">Could not load navigation.</p></div>';
        });
});
