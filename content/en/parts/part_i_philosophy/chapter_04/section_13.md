---
title: "Chapter 4: Piety — Section XIII"
part: "Part I — Philosophy"
chapter: "Chapter 04"
prev: ""
next: ""
section_title: "🧬 The Conscience Scanner"
---

            

<p>The Torah is only to teach us what reason requires. I think ethics is this principle: doing those actions [or words or thoughts] that are in accord with reason and the heart. [I think this way was also the Rambam’s intent though he didn't express it as such.] Thus, there is a certain criteria of reason that if the heart disagrees it means that one's reason is wrong. There is here a basic question for the nature of the standards is different. The traditional way of looking at the laws of the Torah or morality in general is that it is some standard rule of conduct, and that theoretically there is some infinite or finite set of rules for all situations. The Rambam's way is that there is no external set of rules, only internal rules within each person's heart and mind that we may be unaware of because of the physicality of the body that causes us not to hear our minds or heart.</p>
            <p>Thus, there comes a sign to know if someone actually is going to Gan Eden after they pass away or not. If they have no conscience, i.e., no pangs of guilt when they cause some type of emotional pain or otherwise to another person, that is a sign they are completely out of touch with their heart and mind or that their inner heart and mind have left them and thus they will not go to the light afterwards. This is the rational explanation of the Ari who said that by anger one loses his soul [i.e., heart and mind]. If they actually have a tendency to hurt others when the opportunity presents itself, and there is no external constraint, they are evil and go to hell. The reason they do this is because they assert only their rights, not others, and thus come from the breaking of the vessels from which the kelipot came. In Correction all the vessels are together but retain their individual characteristics. By means of that, the higher light is drawn on them. Good people come from that world.</p>
            <p>Now we also see that there are different levels of the soul [heart-mind] that react to different types of sin or lack of good deeds or right knowledge. But we can't differentiate by the five levels of the Kabbalah since they are horizontal levels, rather we have to differentiate vertically as Rabbi Sar Shalom Sharabi did. So, the nefesh of each level [i.e., nefesh of nefesh or nefesh of ruach etc...] reacts to bad deeds by guilty feelings or feels an inner emptiness when there is a lack of good deeds. The foundation of  nefesh reacts to sexual sin. Kindness of nefesh reacts to kindness, i.e., giving or not giving - but judgment of nefesh reacts to cruel deeds. It is a different subject to the soul. The nefesh of ruach reacts to the inner spiritual levels of the physical deed.</p>

<div class="interactive-element soul-scanner">
    <h3>🧬 The Conscience Scanner</h3>
    <div class="scanner-interface">
        <div class="soul-levels">
            <button class="level-btn" onclick="scanLevel('nefesh')">Nefesh (Action)</button>
            <button class="level-btn" onclick="scanLevel('ruach')">Ruach (Speech)</button>
            <button class="level-btn" onclick="scanLevel('neshama')">Neshama (Emotion)</button>
        </div>
        <div class="scan-display">
            <div id="scan-bar" class="scan-line"></div>
            <div id="scan-output" class="scan-text">Select a level to analyze...</div>
        </div>
    </div>
</div>

<style>
.soul-scanner {
    background: #000000;
    padding: 2rem;
    border-radius: var(--radius-lg);
    margin: 2rem 0;
    color: #00ff00; /* Retro terminal feel */
    font-family: monospace;
    border: 1px solid #333;
}

.soul-scanner h3 { color: #00ff00; text-transform: uppercase; letter-spacing: 2px; }

.scanner-interface {
    display: grid;
    grid-template-columns: 1fr 2fr;
    gap: 1.5rem;
    margin-top: 2rem;
}

.soul-levels {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
}

.level-btn {
    background: transparent;
    border: 1px solid #005500;
    color: #00aa00;
    padding: 0.5rem;
    text-align: left;
    cursor: pointer;
    transition: all 0.2s;
    font-family: monospace;
}
.level-btn:hover { background: #002200; color: #00ff00; border-color: #00ff00; }

.scan-display {
    border: 1px solid #005500;
    background: #001100;
    padding: 1rem;
    position: relative;
    min-height: 150px;
    display: flex;
    align-items: center;
    justify-content: center;
    text-align: center;
}

.scan-text {
    z-index: 2;
    line-height: 1.6;
}

.scan-line {
    position: absolute;
    top: 0; left: 0;
    width: 100%; height: 2px;
    background: #00ff00;
    box-shadow: 0 0 10px #00ff00;
    opacity: 0;
    pointer-events: none;
}

@keyframes scan-anim {
    0% { top: 0%; opacity: 1; }
    50% { opacity: 0.5; }
    100% { top: 100%; opacity: 1; }
}

.scanning .scan-line {
    animation: scan-anim 1.5s infinite linear;
    opacity: 1;
}
</style>

<script>
    function scanLevel(level) {
        const out = document.getElementById('scan-output');
        const bar = document.getElementById('scan-bar');
        const box = document.querySelector('.scan-display');
        
        box.classList.add('scanning');
        out.innerText = "Analyzing...";
        
        setTimeout(() => {
            box.classList.remove('scanning');
            if (level === 'nefesh') {
                out.innerHTML = "<strong>NEFESH DETECTED</strong><br>Reaction: Guilt / Empty Void<br>Trigger: Cruelty, Sexual Sin, Lack of Charity";
            } else if (level === 'ruach') {
                out.innerHTML = "<strong>RUACH DETECTED</strong><br>Reaction: Spiritual Numbness<br>Trigger: Bad Words, Lying, Idle Chatter";
            } else if (level === 'neshama') {
                out.innerHTML = "<strong>NESHAMA DETECTED</strong><br>Reaction: Emotional Dissonance<br>Trigger: False Love, Anger, Depression";
            }
        }, 1000);
    }
</script>
            <p>Ruach of each level reacts to bad words in the above manner. Neshamah of each level reacts to emotion, i.e., feeling good about feeling love [i.e., the Strange Loop again or what I call the Strange Spiral that goes to infinity], and feeling guilty about feelings of anger. Chaya is for the mind [feeling good about gaining knowledge] and Yechidah is for the soul of the soul, the archetype soul. [TO THE RASHASH THE MITZVOT ARE THE INNER GARMENTS OF LIGHT, THE CHARACTER IS THE GARMENTS OF SKIN OF THE SOUL. HE ALSO DIVIDES THE CHARACTER INTO FOUR MAIN PARTS. From bottom to top it is humility, silence, despising pleasures of the body, constant happiness in one’s portion. The evil traits are: pride, talking for no purpose, desire, depression... The reason desire is evil is two things. One this is only talking about kelipat noga so it is only evil if one's intention isn't toward God. The other reason is that sexual desire in itself is directed towards all females and thus is a manifestation of the spirit of the species as to increasing the quantity of the species, not the quality. [This idea is from Schopenhauer]. The reason that is evil is that simple continuation is kelipat noga, only going up and improvement relative to one's present position is good.</p>
            
            
        </div>

</div>

        </div>

        


