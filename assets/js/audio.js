// Audio Mode (TTS)
document.addEventListener('DOMContentLoaded', () => {
    // Create Audio Button
    const headerActions = document.querySelector('.header-actions');
    const header = document.querySelector('header');
    if (!headerActions && !header) return;

    // Insert before theme toggle or after
    let audioBtn = document.getElementById('audio-toggle');
    if (!audioBtn) {
        audioBtn = document.createElement('button');
        audioBtn.id = 'audio-toggle';
        audioBtn.className = 'icon-btn';
        audioBtn.textContent = '🎧'; // Headphones
        audioBtn.setAttribute('aria-label', 'Listen to Section');
        audioBtn.setAttribute('title', 'Read Aloud');

        const themeBtn = document.getElementById('theme-toggle');
        if (headerActions && themeBtn) {
            headerActions.insertBefore(audioBtn, themeBtn);
        } else if (headerActions) {
            headerActions.insertBefore(audioBtn, headerActions.firstChild);
        } else if (header) {
            header.appendChild(audioBtn);
        }
    }

    let speaking = false;
    let utterance = null;

    audioBtn.addEventListener('click', () => {
        if (speaking) {
            window.speechSynthesis.cancel();
            speaking = false;
            audioBtn.textContent = '🎧';
            audioBtn.classList.remove('active');
        } else {
            startSpeaking();
        }
    });

    function startSpeaking() {
        const content = document.querySelector('.content-card');
        if (!content) return;

        // Clone to strip non-readable elements?
        // Just reading innerText usually works well enough
        // Exclude footnotes?
        let text = content.innerText;

        // Remove footnotes text roughly "[1]"
        // But innerText might include them.

        if ('speechSynthesis' in window) {
            utterance = new SpeechSynthesisUtterance(text);
            utterance.rate = 1.0;
            utterance.pitch = 1.0;

            // Select voice?
            // Just default for now.

            utterance.onend = () => {
                speaking = false;
                audioBtn.textContent = '🎧';
                audioBtn.classList.remove('active');
            };

            window.speechSynthesis.speak(utterance);
            speaking = true;
            audioBtn.textContent = '⏹️'; // Stop icon
            audioBtn.classList.add('active');
        } else {
            alert("Sorry, your browser doesn't support text-to-speech.");
        }
    }
});
