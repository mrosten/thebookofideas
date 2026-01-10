// Sidebar Navigation Logic - Content is embedded, just handle interactions
document.addEventListener('DOMContentLoaded', () => {
    const sidebarContainer = document.getElementById('sidebar-container');
    const overlay = document.getElementById('sidebar-overlay');
    const toggleBtn = document.getElementById('sidebar-toggle');
    const closeBtn = document.getElementById('close-sidebar');

    if (!sidebarContainer || !overlay || !toggleBtn) {
        console.error('Sidebar elements not found');
        return;
    }

    function openSidebar() {
        sidebarContainer.classList.add('open');
        overlay.classList.add('active');
        document.body.style.overflow = 'hidden';
    }

    function closeSidebar() {
        sidebarContainer.classList.remove('open');
        overlay.classList.remove('active');
        document.body.style.overflow = '';
    }

    // Toggle button opens sidebar
    toggleBtn.addEventListener('click', openSidebar);

    // Close button
    if (closeBtn) {
        closeBtn.addEventListener('click', closeSidebar);
    }

    // Overlay click closes
    overlay.addEventListener('click', closeSidebar);

    // Close on Escape key
    document.addEventListener('keydown', (e) => {
        if (e.key === 'Escape' && sidebarContainer.classList.contains('open')) {
            closeSidebar();
        }
    });

    // Close sidebar when clicking a link (better mobile UX)
    sidebarContainer.querySelectorAll('a').forEach(link => {
        link.addEventListener('click', closeSidebar);
    });
});
