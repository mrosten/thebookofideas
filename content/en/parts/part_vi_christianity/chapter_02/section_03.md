---
title: "Chapter 2: Christianity — Section III"
part: "Part VI — Christianity"
chapter: "Chapter 02"
section_title: "The Paulinistic Deviation"
prev: ""
next: ""
---

### The Spirit of the Church
I heard from Isaac Ram that the Catholic Church has the spirit of Jesus even though they practice forms of idolatry. The more liberal denominations of the church act as a meeting place between Western thought and Jesus, but the spirit of Jesus is really there only in trace amounts.

<!-- VISUAL: THE PAULINE PRISM -->
<style>
  .prism-container {
    background: linear-gradient(145deg, #1a1a1a, #2a2a2a);
    padding: 2rem;
    border-radius: 12px;
    color: white;
    font-family: 'Inter', sans-serif;
    text-align: center;
    position: relative;
    overflow: hidden;
    margin: 3rem 0;
    box-shadow: 0 10px 30px rgba(0,0,0,0.5);
    border: 1px solid #444;
  }
  .prism-stage {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 300px;
    position: relative;
    perspective: 1000px;
  }
  .beam {
    height: 4px;
    background: white;
    position: absolute;
    transform-origin: left center;
    box-shadow: 0 0 15px white;
    border-radius: 2px;
  }
  .beam.input {
    width: 35%;
    left: 0;
    top: 50%;
    /* animation: pulse-beam 2s infinite; */
  }
  .input-label {
    position: absolute;
    left: 10px;
    top: 45%;
    color: white;
    font-size: 0.8rem;
    letter-spacing: 2px;
    text-transform: uppercase;
  }
  
  .prism-triangle {
    width: 0;
    height: 0;
    border-left: 60px solid transparent;
    border-right: 60px solid transparent;
    border-bottom: 100px solid rgba(255, 255, 255, 0.15);
    position: relative;
    z-index: 10;
    backdrop-filter: blur(8px);
    border-bottom-color: rgba(200, 200, 255, 0.25);
    transition: transform 0.5s;
  }
  .prism-triangle:hover { transform: scale(1.05); }

  .prism-label {
    position: absolute;
    top: 40px;
    left: -35px;
    width: 70px;
    text-align: center;
    font-weight: bold;
    color: #ffffff;
    font-size: 0.8rem;
    text-shadow: 0 2px 4px rgba(0,0,0,0.8);
    opacity: 0.8;
  }

  .beam.output {
    width: 0; 
    left: 53%; 
    top: 50%;
    opacity: 0;
    transition: width 1.2s cubic-bezier(0.22, 1, 0.36, 1), opacity 0.5s;
  }
  
  .beam.faith { transform: rotate(-20deg); background: #ff5555; box-shadow: 0 0 15px #ff5555; transform-origin: left center;}
  .beam.love { transform: rotate(20deg); background: #5555ff; box-shadow: 0 0 15px #5555ff; transform-origin: left center;}
  .beam.law { transform: rotate(0deg); background: #55ff55; box-shadow: 0 0 5px #55ff55; width: 0; border-right: none;}

  .label-group {
    position: absolute;
    right: 5%;
    display: flex;
    flex-direction: column;
    justify-content: center;
    gap: 60px;
    text-align: left;
    height: 100%;
    pointer-events: none;
  }
  
  .label-item { 
    font-size: 1rem; 
    font-weight: bold; 
    opacity: 0; 
    transform: translateX(20px); 
    transition: all 0.8s ease; 
  }
  .label-faith { color: #ff8888; }
  .label-love { color: #8888ff; }
  .label-law { color: #88ff88; text-decoration: line-through; opacity: 0; }

  .prism-active .beam.output.faith { width: 35%; opacity: 1; }
  .prism-active .beam.output.love { width: 35%; opacity: 1; }
  .prism-active .beam.output.law { width: 10%; opacity: 0.3; border-right: 2px solid white; } /* Stopped short */

  .prism-active .label-item { opacity: 1; transform: translateX(0); }
  .prism-active .label-law { text-decoration: line-through; opacity: 0.4; }

  .prism-controls { margin-top: 1rem; }
  .prism-btn {
    background: transparent;
    border: 1px solid rgba(255,255,255,0.3);
    color: white;
    padding: 0.8rem 1.5rem;
    cursor: pointer;
    border-radius: 50px;
    transition: all 0.3s;
    font-size: 0.9rem;
    text-transform: uppercase;
    letter-spacing: 1px;
  }
  .prism-btn:hover { background: rgba(255,255,255,0.1); border-color: white; }
</style>

<div class="prism-container" id="paulinePrism">
    <h3 style="margin-top:0; color:white;">The Pauline Prism</h3>
    <p style="opacity:0.8; font-size:0.9rem;">Click to observe how Paul's theology refracts the Torah.</p>
    
    <div class="prism-stage">
        <div class="input-label">TORAH</div>
        <div class="beam input"></div>
        <div class="prism-triangle">
            <div class="prism-label">PAUL</div>
        </div>
        
        <!-- Outputs -->
        <div class="beam output faith"></div>
        <div class="beam output law"></div> <!-- The filtered one -->
        <div class="beam output love"></div>
        
        <div class="label-group">
            <div class="label-item label-faith">FAITH ALONE</div>
            <div class="label-item label-law">COMMANDMENTS</div> <!-- Struck through -->
            <div class="label-item label-love">UNIVERSAL LOVE</div>
        </div>
    </div>
    
    <div class="prism-controls">
        <button class="prism-btn" onclick="togglePrism()">Pass Light Through Paul</button>
    </div>
</div>

<script>
function togglePrism() {
    const container = document.getElementById('paulinePrism');
    const btn = container.querySelector('.prism-btn');
    
    if (container.classList.contains('prism-active')) {
        container.classList.remove('prism-active');
        btn.textContent = "Pass Light Through Paul";
    } else {
        container.classList.add('prism-active');
        btn.textContent = "Reset Filter";
    }
}
</script>


### The Disciples vs. Paul
The disciples of Jesus—those who knew him and whom he chose (as he said "I have chosen you")—suspected that Paul was telling people not to keep the commandments. They sent for him, and he came to Jerusalem to defend himself. He claimed he was only telling non-Jews that they didn't have to become Jewish to be saved, but that he never told Jews not to keep the commandments. To prove his observance, he even performed rituals in the Temple in Jerusalem.

Later, however, the disciples became suspicious again and sent Peter to investigate. As it turned out, their suspicion was correct, as we see in Paul's own letters. 

The **Jerusalem Council** (Acts 15) tried to resolve this, but the rift remained fundamental.

<blockquote class="fancy-quote">
<strong>"The righteous shall live by his faith."</strong><br>
— <em>Habakkuk 2:4 (Paul's Justification)</em>
</blockquote>

Contrast this with the words of Jesus himself, which the disciples upheld:

<blockquote class="fancy-quote">
<strong>"Do not think that I have come to abolish the Law or the Prophets; I have not come to abolish them but to fulfill them."</strong><br>
— <em>Matthew 5:17</em>
</blockquote>

And the rebuke from James, likely directed at Paul's rising influence:

<blockquote class="fancy-quote">
<strong>"You see that a person is considered righteous by what they do and not by faith alone."</strong><br>
— <em>James 2:24</em>
</blockquote>

### The Evidence of the Letters
These letters were written over several years and perhaps represent Paul's evolving ideas, but they clearly outline a doctrine that the original disciples of Jesus considered false—so much so that they threatened to excommunicate him. Paul's letters reveal a fundamental shift: the replacement of the **Law of God** with the new rituals of the Church.

In his letter to the Galatians [Gal. 2:6, in 57AD], Paul writes about the disciples of Jesus who were the leaders of the church in Jerusalem: *"those people who are acknowledged as leaders — not that their importance matters to me."* In 2 Corinthians 11:3-4, he acknowledges that the disciples of Jesus were teaching about "another Jesus" different from the one he was preaching.

<div class="concept-box">
    <strong>Paul's Motivation</strong><br>
    Perhaps Paul held like Rashi in <em>Makkot 24</em> ("The righteous shall live by his faith"), attempting to condense the Torah into a single principle of Faith/Love to make it accessible to the pagan world. However, his hatred of the Law seems to have gone beyond simplification into nullification.
</div>

<hr class='divider'>
