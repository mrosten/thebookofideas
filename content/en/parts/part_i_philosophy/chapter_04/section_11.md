---
title: "Chapter 4: Piety — Section XI"
part: "Part I — Philosophy"
chapter: "Chapter 04"
prev: ""
next: ""
section_title: "🏺 The Vessel and the Light"
---

            

<p>In general, I have noticed that modern day Orthodox Judaism is a totally different religion than that of the Rambam, and the other Jewish Sages of the Medieval period. To me, that seems ironic, for they claim that the other Jews have gone off the path. It seems that orthodox Judaism has been on a downward-spiral for some time to take the spirituality out of religion. If you'll notice in Hamlet, that Hamlet felt that since in his prayer he hadn't succeed to connect with God, that it wasn't really a prayer. Shakespeare’s whole attitude towards that is that this was in fact the case, for he considers it ironic that he was spared by seeming to pray. So, we see a general attitude that trying to pray isn't necessarily praying, but in orthodox Judaism all the prayers are exactly like that, and if one even attempts to put a little extra into his prayers, he is looked down upon and all the more so if he tries to pray with the intentions of the Kabbalah. [Nowadays, Orthodoxy has become an anti-spiritual movement].</p>
            <p>Historically, I believe we can trace a long progression of Orthodox Judaism attempting to take spirituality out of the Torah. No longer is God a weighty subject in Judaism. Now it is the Laws [halacha] for the orthodox, or social justice for the Reform — but God simply has become a concept that is mentioned for the sake of lip service. Thus, we see that the Sanhedrin in the days of Moses tried to convict him for being a false prophet [Korach and the heads of the Sanhedrin as Rashi says]. Thus, we find the Torah establishment of David's time siding with Saul — as the Gemara Shabbat explains [Doeg was the head of the Sanhedrin]. Thus, we find most of the rabbis of the Rambam's time trying to excommunicate him, and thus we find the rabbis of later times condemning the Kabbalah. In all these cases a generation has to go by, and sometimes much more, until the truth is accepted — but by then it is sterilized, so as to become non-effective.</p>
            <p>Now, all of them are considered great, but their teachings are ignored when they aren't politically correct. Physical mitzvot, to the Rambam, are to provide an environment for spiritual growth, but do not cause it. Physical actions can in no way stimulate internal growth. If knowing lots of laws makes one spiritual, then Big Blue the computer is more spiritual than all the rabbis together! In yeshivot, it is the accepted way to delve deeply into every word and letter of the Rambam. I wonder when they will get around to delving into the exact meaning of “Consequently he who wishes to reach perfection, must first study Logic, then the different parts of Mathematics in their right order, then Physics, then Metaphysics”! — and be exacting in every word and every letter.</p>

<div class="interactive-element spirit-form-visual">
    <h3>🏺 The Vessel and the Light</h3>
    
    <div class="vessel-container">
        <div class="vessel" id="ritual-vessel">
            <div class="inner-light" id="ritual-light"></div>
            <div class="vessel-label">Halacha (Form)</div>
        </div>
        
        <div class="controls">
            <button class="toggle-btn active" id="btn-empty" onclick="setVessel('empty')">Empty Ritual</button>
            <button class="toggle-btn" id="btn-full" onclick="setVessel('full')">Full Intention</button>
        </div>
    </div>
    
    <div class="quote-display" id="vessel-quote">
        "Trying to pray isn't necessarily praying... Hamlet felt it wasn't really a prayer."
    </div>
</div>

<style>
.spirit-form-visual {
    background: linear-gradient(135deg, #1e293b 0%, #0f172a 100%);
    padding: 2.5rem;
    border-radius: var(--radius-lg);
    margin: 2rem 0;
    text-align: center;
    color: white;
    border: 1px solid #334155;
}

.vessel-container {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 2rem;
    margin: 2rem 0;
}

.vessel {
    width: 120px;
    height: 160px;
    border: 4px solid var(--accent-gold);
    border-radius: 0 0 40px 40px;
    border-top: none;
    position: relative;
    display: flex;
    justify-content: center;
    align-items: flex-end;
    overflow: hidden;
    background: rgba(255,255,255,0.05);
}

.vessel::before { /* Rim */
    content: '';
    position: absolute;
    top: 0;
    left: -4px;
    width: calc(100% + 8px);
    height: 20px;
    border: 4px solid var(--accent-gold);
    border-radius: 50%;
    margin-top: -10px;
}

.inner-light {
    width: 100%;
    height: 0%;
    background: radial-gradient(circle, #fbbf24 0%, #d97706 100%);
    box-shadow: 0 0 30px #fbbf24;
    transition: height 1s cubic-bezier(0.4, 0, 0.2, 1);
    opacity: 0.8;
}

.controls {
    display: flex;
    gap: 1rem;
}

.toggle-btn {
    background: transparent;
    border: 1px solid var(--accent-gold);
    color: var(--accent-gold);
    padding: 0.5rem 1rem;
    border-radius: 20px;
    cursor: pointer;
    font-family: var(--font-ui);
    transition: all 0.3s;
}

.toggle-btn:hover, .toggle-btn.active {
    background: var(--accent-gold);
    color: #0f172a;
}

.quote-display {
    font-style: italic;
    color: #94a3b8;
    min-height: 3rem;
}
</style>

<script>
    function setVessel(state) {
        const light = document.getElementById('ritual-light');
        const quote = document.getElementById('vessel-quote');
        const btns = document.querySelectorAll('.toggle-btn');
        
        btns.forEach(b => b.classList.remove('active'));
        
        if (state === 'empty') {
            light.style.height = '5%';
            document.getElementById('btn-empty').classList.add('active');
            quote.innerText = '"Taki" (Empty Form): Just going through the motions. The body is here, but the soul is absent.';
        } else {
            light.style.height = '100%';
            document.getElementById('btn-full').classList.add('active');
            quote.innerText = '"Kavanah" (Full Intention): The vessel is filled with the Light of the Infinite. The Ritual becomes a Gateway.';
        }
    }
</script>
            
            
        </div>

</div>

        </div>

        


