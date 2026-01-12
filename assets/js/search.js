// Instant Search
document.addEventListener('DOMContentLoaded', () => {
    const searchToggle = document.getElementById('search-toggle');
    const searchModal = document.getElementById('search-modal');
    const searchInput = document.getElementById('search-input');
    const searchResults = document.getElementById('search-results');
    const backdrop = document.querySelector('.search-backdrop');

    if (!searchToggle || !searchModal) {
        console.error('Search elements not found');
        return;
    }

    let searchIndex = [];
    let isLoaded = false;
    let isLoading = false;

    // Determine root path
    let rootPath = '';
    const pathname = window.location.pathname.replace(/\\/g, '/');
    const pathSegments = pathname.split('/').filter(s => s.length > 0);

    const partsIndex = pathSegments.indexOf('parts');
    if (partsIndex !== -1) {
        const depth = pathSegments.length - partsIndex - 1;
        rootPath = '../'.repeat(depth);
    }

    console.log('Search: rootPath =', rootPath);

    // Open Search
    searchToggle.addEventListener('click', async () => {
        searchModal.style.display = 'block';
        searchInput.focus();

        if (!isLoaded && !isLoading) {
            isLoading = true;
            searchResults.innerHTML = '<p style="padding:1rem;color:#999;">Loading search index...</p>';

            try {
                const url = rootPath + 'search_index.json';
                console.log('Fetching search index from:', url);
                const response = await fetch(url);
                if (!response.ok) throw new Error(`HTTP ${response.status}`);
                searchIndex = await response.json();
                isLoaded = true;
                searchResults.innerHTML = '<p style="padding:1rem;color:#999;">Type to search...</p>';
                console.log('Search index loaded:', searchIndex.length, 'entries');
            } catch (e) {
                console.error("Failed to load search index:", e);
                searchResults.innerHTML = `<p style="padding:1rem;color:#c00;">Error loading search data: ${e.message}</p>`;
            }
            isLoading = false;
        }
    });

    // Close Search
    if (backdrop) {
        backdrop.addEventListener('click', () => {
            searchModal.style.display = 'none';
        });
    }

    // Also close on Escape key
    document.addEventListener('keydown', (e) => {
        if (e.key === 'Escape' && searchModal.style.display === 'block') {
            searchModal.style.display = 'none';
        }
    });

    // Search Logic
    if (searchInput) {
        searchInput.addEventListener('input', (e) => {
            const query = e.target.value.toLowerCase().trim();
            if (query.length < 2) {
                searchResults.innerHTML = '<p style="padding:1rem;color:#999;">Type at least 2 characters...</p>';
                return;
            }

            if (!isLoaded) {
                searchResults.innerHTML = '<p style="padding:1rem;color:#999;">Search index not loaded yet...</p>';
                return;
            }

            const results = searchIndex.filter(item =>
                item.title.toLowerCase().includes(query) ||
                (item.content && item.content.toLowerCase().includes(query))
            ).slice(0, 10);

            if (results.length === 0) {
                searchResults.innerHTML = '<p class="no-results">No results found.</p>';
            } else {
                searchResults.innerHTML = results.map(item => {
                    let snippet = '';
                    if (item.content) {
                        const idx = item.content.toLowerCase().indexOf(query);
                        const start = Math.max(0, idx - 40);
                        const end = Math.min(item.content.length, idx + 100);
                        snippet = item.content.substring(start, end) + '...';
                        snippet = snippet.replace(new RegExp(query, 'gi'), match => `<mark>${match}</mark>`);
                    }

                    return `
                    <div class="search-result-item">
                        <a href="${rootPath}${item.url}">
                            <strong>${item.title}</strong>
                            <span class="result-path">${item.part} > ${item.chapter}</span>
                            <p>${snippet}</p>
                        </a>
                    </div>`;
                }).join('');
            }
        });
    }
});
