---
title: "Chapter 1: Ideas In Kabbalah — Section XIX"
part: "Part V"
chapter: "Chapter 01"
prev: ""
next: ""
section_title: "Recursion of the Void"
---

            


<h3 class="section-title">Recursion of the Void</h3>
<blockquote class="fancy-quote">
            "There are ten empty spaces, and each is divisible into ten... ad infinitum." — The Fractal Void.
            </blockquote>
            
            <!-- Interactive Visual: Fractal Void -->
            <div class="interactive-element fractal-visual">
                <div class="fractal-container">
                    <canvas id="fractalCanvas" width="500" height="300"></canvas>
                </div>
                
                <div class="fractal-controls">
                    <button class="frac-btn active" onclick="setFrac('zoom')" id="btn-zoom">Zoom In (Recursion)</button>
                    <button class="frac-btn" onclick="setFrac('static')" id="btn-static">Static View (Structure)</button>
                </div>
                
                <div class="fractal-readout" id="frac-status">Mode: RECURSIVE ZOOM. Infinite descent into the void.</div>
            </div>
            
            <style>
            .fractal-visual { background: var(--primary-deep); border-radius: var(--radius-lg); padding: 2.5rem; margin: 3rem 0; border: 1px solid rgba(197, 160, 89, 0.2); text-align: center; }
            
            .fractal-container { background: #020617; border-radius: var(--radius-md); overflow: hidden; margin-bottom: 2rem; border: 1px solid #334155; position: relative; }
            
            .fractal-controls { display: flex; justify-content: center; gap: 1rem; margin-bottom: 1.5rem; }
            
            .frac-btn { background: rgba(255,255,255,0.05); border: 1px solid rgba(255,255,255,0.1); color: #cbd5e1; padding: 0.75rem 1.5rem; border-radius: var(--radius-md); cursor: pointer; transition: all 0.3s; font-family: monospace; }
            .frac-btn:hover { background: rgba(255,255,255,0.1); }
            .frac-btn.active { background: var(--accent-gold); color: #020617; border-color: var(--accent-gold); font-weight: 700; }
            
            .fractal-readout { font-family: monospace; color: #94a3b8; font-size: 0.9rem; }
            </style>
            
            <script>
            (function(){
                const canvas = document.getElementById('fractalCanvas');
                const ctx = canvas.getContext('2d');
                let mode = 'zoom';
                let t = 0;
                
                function draw() {
                    ctx.clearRect(0,0, canvas.width, canvas.height);
                    const cx = canvas.width / 2;
                    const cy = canvas.height / 2;
                    
                    if(mode === 'zoom') {
                        t += 0.02;
                    } 
                    
                    // Recursive circles
                    let scale = (t % 1) * 10; 
                    
                    for(let i=0; i<10; i++) {
                        let r = 200 * Math.pow(0.6, i) * (mode === 'zoom' ?  Math.pow(1.5, t%5) : 1);
                        // Prevent exploding R
                        if(r > 400) r = 400; // Clip
                        
                        ctx.beginPath(); ctx.arc(cx, cy, r, 0, Math.PI*2);
                        ctx.strokeStyle = `hsla(${i*36}, 70%, 50%, 0.8)`;
                        ctx.lineWidth = 2; ctx.stroke();
                        
                        // Inner "Sephirot"
                         ctx.beginPath(); ctx.arc(cx + r*0.5, cy, r*0.1, 0, Math.PI*2); ctx.fillStyle='rgba(255,255,255,0.3)'; ctx.fill();
                        
                    }
                    
                    ctx.fillStyle = '#fff'; ctx.fillText("10 Spaces within 10 Spaces...", cx-80, cy+140);
                    
                    requestAnimationFrame(draw);
                }
                
                window.setFrac = function(m) {
                    mode = m;
                    document.querySelectorAll('.frac-btn').forEach(b => b.classList.remove('active'));
                    if(m === 'zoom') {
                        document.getElementById('btn-zoom').classList.add('active');
                        document.getElementById('frac-status').innerText = "Mode: RECURSIVE ZOOM. Finding the Infinite within the Finite.";
                        document.getElementById('frac-status').style.color = "#fbbf24";
                    } else {
                        document.getElementById('btn-static').classList.add('active');
                        document.getElementById('frac-status').innerText = "Mode: STATIC STRUCTURE. The Nested Spheres.";
                        document.getElementById('frac-status').style.color = "#94a3b8";
                    }
                };
                
                draw();
            })();
            </script>
            
            <h4>Nested Dimensions</h4>
            <p>There are ten empty spaces, each divisible into ten ad infinitum. Each exists on a different plane. For instance, our 3D sphere is surrounded by a 4D sphere (Royalty of the Infinite). The diagram below illustrates this nesting.</p>
            
            <div class='image-container center-img'>
                <img src='../../../../images/fractal_void_blueprint.png' alt='Fractal Void Blueprint of Nested Spheres' class='book-image' style="max-width: 80%; border-radius: 8px; box-shadow: 0 0 15px rgba(96, 165, 250, 0.3);">
            </div>

            <p>The time-axis is negative, implying that to get the regular order, one must turn the diagram upside down. This relates to the Chassidic teaching equating *Tohu* (Chaos) with the angles of the Divine Chariot.</p>

