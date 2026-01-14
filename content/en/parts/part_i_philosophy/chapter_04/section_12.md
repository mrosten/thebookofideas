---
title: "Chapter 4: Piety — Section XII"
part: "Part I — Philosophy"
chapter: "Chapter 04"
prev: ""
next: ""
section_title: "🫧 The Bubble of Strictness"
---

            

<p>It is a very worthwhile experience not to get your prayers answered so that you realize that your prayers and trusting on God and your good deeds can't cause God to do your will. This is the case no matter how powerful and deep your prayers are. It is a big ego trip to think that with your prayers you can force him to do your will. Trust and prayer are good things when done with the right viewpoint - that God will do what he knows to be the right thing no matter what. But prayer also can help but only sometimes.</p>
            <p>There are two ways of approaching tolerance: a) Perhaps tolerance is not a virtue in itself, but what is wrong with the orthodox is that they forget that the Torah says don't add to the commandments, and they keep closing the bubble more and more until there is no room to breathe. (They, of course don't keep these standards. They just sin and repent afterwards. But the conventions are useful in that they provide a way of oppressing everyone else.) Besides that, they are intolerant of behavior outside of their conventions, which have nothing to do with the Torah and many times contradict the Torah. But even the non-religious recognize an outer limit for the bubble. The good thing about the non-religious is that they have an outer limit and inner limit and so have a pretty good idea of where to put the limits of behavior. The religious, however, don't recognize that an inner limit can exist, and they get stricter and make the bubble smaller and smaller until they condense into the Swartzchild radius of a black hole from which there is no escape unless, like me, you just come out the other side. (That is why they and Greek Orthodox wear black clothes to warn people that they represent a spiritual black hole.) b) Another approach is that tolerance is a virtue in itself and that God Himself has different standards for every person and that even God himself loves tolerance and allows a person a wide range of opportunity to choose his own behavior within certain limits that apply that person's soul.</p>

<div class="interactive-element tolerance-bubble">
    <h3>🫧 The Bubble of Strictness</h3>
    <div class="bubble-container">
        <div class="bubble-space">
            <!-- The Field of Life -->
            <div class="field-limit outer-limit">Outer Limit (Halacha)</div>
            
            <!-- The Bubble -->
            <div id="ortho-bubble" class="bubble">
                <div class="bubble-label">Acceptable Behavior</div>
            </div>
            
            <div class="field-limit inner-limit">Inner Limit (Conscience)</div>
        </div>
        
        <div class="controls">
            <input type="range" id="strictness-slider" min="0" max="100" value="50">
            <label for="strictness-slider">Strictness Level</label>
        </div>
        
        <p id="bubble-status" class="status-text">State: Balanced</p>
    </div>
</div>

<style>
.tolerance-bubble {
    background: linear-gradient(135deg, #1e1b4b 0%, #0f172a 100%);
    padding: 2rem;
    border-radius: var(--radius-lg);
    margin: 2rem 0;
    text-align: center;
    color: white;
    border: 1px solid #312e81;
}

.bubble-container {
    max-width: 400px;
    margin: 0 auto;
}

.bubble-space {
    height: 250px;
    position: relative;
    border: 2px dashed rgba(255,255,255,0.2);
    border-radius: var(--radius-md);
    margin: 1.5rem 0;
    display: flex;
    justify-content: center;
    align-items: center;
    background: rgba(0,0,0,0.2);
    overflow: hidden;
}

.field-limit {
    position: absolute;
    width: 100%;
    text-align: center;
    font-size: 0.7rem;
    color: rgba(255,255,255,0.5);
    border-top: 1px dotted rgba(255,255,255,0.3);
}
.outer-limit { top: 10px; }
.inner-limit { bottom: 10px; border-top: none; border-bottom: 1px dotted rgba(255,255,255,0.3); }

.bubble {
    width: 200px;
    height: 200px;
    background: rgba(56, 189, 248, 0.2);
    border: 2px solid #38bdf8;
    border-radius: 50%;
    display: flex;
    justify-content: center;
    align-items: center;
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    box-shadow: 0 0 20px rgba(56, 189, 248, 0.2);
}

.bubble-label {
    font-weight: bold;
    font-size: 0.9rem;
    color: #bae6fd;
    text-shadow: 0 2px 4px rgba(0,0,0,0.5);
}

#strictness-slider {
    width: 100%;
    cursor: pointer;
    margin-bottom: 0.5rem;
}

.status-text {
    font-family: monospace;
    color: var(--accent-gold);
    min-height: 1.5rem;
}
</style>

<script>
    const bSlider = document.getElementById('strictness-slider');
    const bubble = document.getElementById('ortho-bubble');
    const bStatus = document.getElementById('bubble-status');

    bSlider.addEventListener('input', (e) => {
        const val = parseInt(e.target.value);
        // 0 = Wide open, 100 = Black Hole
        
        // Size: 220px -> 10px
        const size = 220 - (val * 2.1);
        bubble.style.width = `${size}px`;
        bubble.style.height = `${size}px`;
        
        if (val > 95) {
            bubble.style.background = "black";
            bubble.style.borderColor = "white";
            bubble.style.boxShadow = "0 0 30px white"; // Event horizon
            bStatus.innerText = "State: SINGULARITY (No Escape)";
            bStatus.style.color = "#ef4444";
        } else if (val > 80) {
            bubble.style.background = "rgba(0,0,0,0.8)";
            bubble.style.borderColor = "#94a3b8";
            bStatus.innerText = "State: Oppressive Conformity";
            bStatus.style.color = "#facc15";
        } else if (val > 40) {
            bubble.style.background = "rgba(56, 189, 248, 0.2)";
            bubble.style.borderColor = "#38bdf8";
            bStatus.innerText = "State: Healthy Boundaries";
            bStatus.style.color = "#4ade80";
        } else {
            bubble.style.background = "rgba(16, 185, 129, 0.1)";
            bubble.style.borderColor = "#10b981";
            bStatus.innerText = "State: Permissive / Wide";
            bStatus.style.color = "#10b981";
        }
    });
</script>
            <p>However, I think there really is not one border-line but two. There is an outer and an inner limit different for every person, but they fall into a binomial pattern so that the Torah can state certain basic behavior patterns that are acceptable. And, besides this, there is a great interval between the limits where free will and opportunity exist for growth. The difference between the areas is the gray area is where tolerance applies, and the white area is simply permitted. The rule is that teachers of morality can't be moral in people's eyes. God will always cause a situation to arise where they will seem not moral. This is for the sake of free-will. Also, it makes it indistinguishable between hypocrites and sincere teachers which also is necessary for free will.</p>
            <p>There is a very basic difference between the Rambam's idea of morality and ethics and the general religious view. To the general view it is doing what the Torah says. This view I have ascribed to in much of this book. But, to the Rambam the criteria is Reason.</p>
            
            
        </div>

</div>

        </div>

        


