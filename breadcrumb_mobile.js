// Mobile breadcrumb dropdown - two-tap pattern
// First tap shows dropdown, second tap navigates

(function () {
    'use strict';

    // Only apply on touch devices
    const isTouchDevice = 'ontouchstart' in window || navigator.maxTouchPoints > 0;
    if (!isTouchDevice) return;

    let activeDropdown = null;

    document.addEventListener('DOMContentLoaded', function () {
        const dropdownItems = document.querySelectorAll('.breadcrumb-item.has-dropdown > a');

        dropdownItems.forEach(function (link) {
            link.addEventListener('click', function (e) {
                const parent = this.parentElement;
                const dropdown = parent.querySelector('.breadcrumb-dropdown');

                // If this dropdown is not currently shown, show it and prevent navigation
                if (!parent.classList.contains('dropdown-active')) {
                    e.preventDefault();
                    e.stopPropagation();

                    // Close any other open dropdowns
                    document.querySelectorAll('.breadcrumb-item.dropdown-active').forEach(function (item) {
                        item.classList.remove('dropdown-active');
                    });

                    // Show this dropdown
                    parent.classList.add('dropdown-active');
                    activeDropdown = parent;
                }
                // If already shown, allow navigation (second tap)
            });
        });

        // Close dropdown when tapping elsewhere
        document.addEventListener('click', function (e) {
            if (activeDropdown && !activeDropdown.contains(e.target)) {
                activeDropdown.classList.remove('dropdown-active');
                activeDropdown = null;
            }
        });

        // Close dropdown when scrolling
        document.addEventListener('scroll', function () {
            if (activeDropdown) {
                activeDropdown.classList.remove('dropdown-active');
                activeDropdown = null;
            }
        });
    });
})();
