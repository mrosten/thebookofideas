---
title: "Chapter 4: Piety — Section XIV"
part: "Part I — Philosophy"
chapter: "Chapter 04"
prev: ""
next: ""
section_title: "🌳 The Tree of Intention"
---

            

<p>For mitzvot that you don't feel light from you will not get any reward in the next world therefrom. There really is not all that much difference between here and there. So, if you don’t feel any light then believe me, there isn't any. This is why the Torah only promises good in this world for doing the mitzvot. Since the next world is not dependent on mitzvoth, only this world is. However, if you feel the light then in all likelihood you are on the right track for there too. However, since getting there is such a fragile thing it is worth it to have a guarantee. So, this is why it is worth it to get to the grave of Rabbi Nachman, say the ten psalms and give a penny for charity, in which case he promised he would take that person that does this out of hell, an unpleasant place by all accounts.</p>
            <p>It is forbidden to change one’s religion since it is impossible to get the spiritual blessing except from the root one was born from as already mentioned by the kabbalists from the Middle Ages. But there is another reason, i.e., that religion is the images and stories embedded into one's consciousness when he is young. One can never change that, nor is it desirable to. One can always stick with his own religion and just take out the things that are forbidden. True religion isn't a bunch of rules, it is a way to approach God. And that can only be done with the totality of one's consciousness.</p>
            <p>Fear of God is being aware of the presence of God and fearing Him. It is not the same thing as faith. Faith is Royalty and fear is Judgment [and the higher fear {awe} is Wisdom]. Fear is not the same thing as being strict in observing commandments. In fact, the original idea of Chasidut was that there is nothing besides God, and that therefore it is possible to serve God with everything and through everything as long as serving God is one's intention. It was the first 1960's, where sex and fun and spirituality was all possible in one package. There is no question that there was much illicit sex at the beginning of Chasidut [as the affidavits signed in Vilna testify to], and for this reason the Gra went against the idea that there is nothing but God until Reb Chayim of Voloshin [his disciple] came and agreed with it, but explained it in a way that would not contradict the law and thus this idea came part of the body of accepted doctrine of the Torah. However, to be fair the original doctrine of Chasidut was not to go against Halacha but rather to be as lenient as possible since fear of God has nothing to do with being strict.</p>
            <p>The idea of chassidus as taken by people in general was do what you want and intend it for God and that is accepted by God as Divine service [as long as you don't do evil] since there is nothing besides God and everything is God. It was “Serve God by having fun,” [i.e., serve God with joy/fun]. This wasn't appreciated by the Gra and most rabbis. When they would go on the street and ask the youth why are you behaving so wildly the answer wasn't ‘Go to hell,’ but rather, “This is our Divine service.” Giving a spiritual motive to have fun was unappreciated by the Gra. To a degree this was rightly so since just like the Flower Children of the 60s’ deteriorated into the Yuppies of the 70s’, so the movement of chassidus reversed its polarity from super spiritual to super material until today it is the worship of money and power.</p>

<div class="interactive-element tradition-tree">
    <h3>🌳 The Tree of Intention</h3>
    <div class="tree-container">
        <canvas id="tree-canvas" width="300" height="200"></canvas>
        <div class="tree-controls">
            <button class="tree-btn" onclick="growTree('strict')">Strategy: Strictness (Gra)</button>
            <button class="tree-btn" onclick="growTree('love')">Strategy: Love (Besht)</button>
        </div>
        <p id="tree-message" class="tree-message">Choose a path to grow the tree...</p>
    </div>
</div>

<style>
.tradition-tree {
    background: #ecfdf5;
    padding: 2rem;
    border-radius: var(--radius-lg);
    margin: 2rem 0;
    text-align: center;
    color: #064e3b;
    border: 1px solid #10b981;
}
[data-theme="dark"] .tradition-tree {
    background: #022c22;
    color: #ecfdf5;
    border-color: #065f46;
}

.tree-container {
    position: relative;
}

#tree-canvas {
    background: rgba(255,255,255,0.1);
    border-radius: var(--radius-md);
    margin-bottom: 1rem;
}

.tree-controls {
    display: flex;
    justify-content: center;
    gap: 1rem;
    margin-bottom: 1rem;
}

.tree-btn {
    padding: 0.5rem 1rem;
    border: 2px solid #10b981;
    background: transparent;
    border-radius: 20px;
    cursor: pointer;
    font-weight: bold;
    color: inherit;
    transition: all 0.3s;
}

.tree-btn:hover {
    background: #10b981;
    color: white;
}

.tree-message {
    font-style: italic;
    font-size: 0.9rem;
    min-height: 1.5rem;
}
</style>

<script>
    const canvas = document.getElementById('tree-canvas');
    const ctx = canvas.getContext('2d');
    const msg = document.getElementById('tree-message');

    function drawBranch(x, y, len, angle, width, color) {
        ctx.beginPath();
        ctx.save();
        ctx.strokeStyle = color;
        ctx.lineWidth = width;
        ctx.translate(x, y);
        ctx.rotate(angle * Math.PI/180);
        ctx.moveTo(0, 0);
        ctx.lineTo(0, -len);
        ctx.stroke();
        
        if (len < 10) {
            ctx.restore();
            return;
        }

        drawBranch(0, -len, len*0.75, angle-15, width*0.7, color);
        drawBranch(0, -len, len*0.75, angle+15, width*0.7, color);
        ctx.restore();
    }

    function growTree(type) {
        ctx.clearRect(0, 0, canvas.width, canvas.height);
        
        if (type === 'strict') {
            // Straight, rigid tree
            drawStraightTree(150, 200, 60, 0, 10);
            msg.innerText = "The Path of Strictness: Upright, strong, but rigid.";
        } else {
            // Wild, organic tree
            drawOrganicTree(150, 200, 60, 0, 10);
            msg.innerText = "The Path of Love: Wild, expansive, but chaotic.";
        }
    }

    function drawStraightTree(x, y, len, angle, width) {
        ctx.beginPath();
        ctx.save();
        ctx.strokeStyle = "#059669";
        ctx.lineWidth = width;
        ctx.translate(x, y);
        ctx.rotate(angle * Math.PI/180);
        ctx.moveTo(0, 0);
        ctx.lineTo(0, -len);
        ctx.stroke();
        
        if (len < 10) { ctx.restore(); return; }
        
        drawStraightTree(0, -len, len*0.8, -20, width*0.7);
        drawStraightTree(0, -len, len*0.8, 20, width*0.7);
        ctx.restore();
    }

    function drawOrganicTree(x, y, len, angle, width) {
        ctx.beginPath();
        ctx.save();
        ctx.strokeStyle = "#d97706";
        ctx.lineWidth = width;
        ctx.translate(x, y);
        ctx.rotate(angle * Math.PI/180);
        ctx.moveTo(0, 0);
        
        // Curvy line
        ctx.bezierCurveTo(10, -len/3, -10, -len*2/3, 0, -len);
        ctx.stroke();
        
        if (len < 10) { ctx.restore(); return; }
        
        drawOrganicTree(0, -len, len*0.8, -25 + Math.random()*10, width*0.7);
        drawOrganicTree(0, -len, len*0.8, 25 + Math.random()*10, width*0.7);
        ctx.restore();
    }
    
    // Initial draw
    ctx.font = "14px serif";
    ctx.fillStyle = "#059669";
    ctx.fillText("Select a path...", 110, 180);
</script>
            
            
        </div>

</div>

        </div>

        


