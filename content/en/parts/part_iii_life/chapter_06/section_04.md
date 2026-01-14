---
title: "Chapter 6: Success — Section IV"
part: "Part III — Life"
chapter: "Chapter 06"
prev: ""
next: ""
section_title: "The Choice of Life"
---

            

<blockquote class="fancy-quote">
            "The measure one measures out, is measured to him again." — The Law of Measured Return.
            </blockquote>
            
            <!-- Interactive Visual: Soul Root Compass -->
            <div class="interactive-element compass-visual">
                <div class="compass-container">
                    <div class="compass-ring">
                        <div class="compass-needle" id="needle"></div>
                        <div class="compass-label label-n">Emanation</div>
                        <div class="compass-label label-e">Creation</div>
                        <div class="compass-label label-s">Action</div>
                        <div class="compass-label label-w">Formation</div>
                    </div>
                </div>
                
                <div class="compass-controls">
                    <div class="control-row">
                        <button class="root-btn" onclick="setRoot('emanation')" id="btn-emanation">Atzilut (Emanation)</button>
                        <button class="root-btn" onclick="setRoot('creation')" id="btn-creation">Beriah (Creation)</button>
                    </div>
                    <div class="control-row">
                        <button class="root-btn" onclick="setRoot('formation')" id="btn-formation">Yetzirah (Formation)</button>
                        <button class="root-btn" onclick="setRoot('action')" id="btn-action">Asiyah (Action)</button>
                    </div>
                </div>
                
                <div class="info-panel-compass" id="compass-info">
                    <h5 id="compass-title">Select a Soul Root</h5>
                    <div class="compass-stat">
                        <span class="stat-label">Intuition Accuracy:</span>
                        <div class="stat-bar-bg"><div class="stat-bar-fill" id="bar-accuracy" style="width: 0%"></div></div>
                    </div>
                    <p id="compass-desc" class="compass-text">Each soul root has a different internal guidance system.</p>
                </div>
            </div>
            
            <style>
            .compass-visual { background: var(--primary-deep); border-radius: var(--radius-lg); padding: 2.5rem; margin: 3rem 0; border: 1px solid rgba(197, 160, 89, 0.2); text-align: center; }
            
            .compass-container { position: relative; width: 200px; height: 200px; margin: 0 auto 2rem; }
            
            .compass-ring { width: 100%; height: 100%; border: 4px solid #cbd5e1; border-radius: 50%; position: relative; background: radial-gradient(circle, #1e293b 0%, #020617 100%); box-shadow: 0 0 20px rgba(0,0,0,0.5); }
            
            .compass-needle { position: absolute; top: 50%; left: 50%; width: 4px; height: 140px; background: linear-gradient(to top, #f87171 50%, #4ade80 50%); transform: translate(-50%, -50%) rotate(0deg); transition: transform 1s cubic-bezier(0.175, 0.885, 0.32, 1.275); clip-path: polygon(50% 0%, 100% 50%, 50% 100%, 0% 50%); }
            .compass-needle::after { content: ''; position: absolute; top: 50%; left: 50%; width: 10px; height: 10px; background: #cbd5e1; border-radius: 50%; transform: translate(-50%, -50%); }
            
            .compass-label { position: absolute; font-size: 0.7rem; color: #94a3b8; text-transform: uppercase; letter-spacing: 1px; }
            .label-n { top: 10px; left: 50%; transform: translateX(-50%); }
            .label-s { bottom: 10px; left: 50%; transform: translateX(-50%); }
            .label-e { right: 5px; top: 50%; transform: translateY(-50%); }
            .label-w { left: 5px; top: 50%; transform: translateY(-50%); }
            
            .compass-controls { margin-bottom: 2rem; }
            .control-row { display: flex; justify-content: center; gap: 0.5rem; margin-bottom: 0.5rem; }
            
            .root-btn { background: rgba(255,255,255,0.05); border: 1px solid rgba(255,255,255,0.1); color: #cbd5e1; padding: 0.5rem 1rem; border-radius: var(--radius-md); cursor: pointer; transition: all 0.3s; font-family: monospace; font-size: 0.8rem; width: 160px; }
            .root-btn:hover { background: rgba(255,255,255,0.1); }
            .root-btn.active { background: var(--accent-gold); color: #020617; border-color: var(--accent-gold); font-weight: 700; }
            
            .info-panel-compass { background: rgba(0,0,0,0.2); padding: 1.5rem; border-radius: var(--radius-md); text-align: left; }
            .info-panel-compass h5 { color: var(--accent-gold); margin-bottom: 1rem; font-family: 'Cinzel', serif; text-align: center; }
            
            .compass-stat { display: flex; align-items: center; gap: 1rem; margin-bottom: 1rem; }
            .stat-label { font-family: monospace; color: #94a3b8; font-size: 0.9rem; min-width: 140px; }
            .stat-bar-bg { flex-grow: 1; height: 6px; background: #334155; border-radius: 3px; overflow: hidden; }
            .stat-bar-fill { height: 100%; background: #4ade80; transition: width 0.5s; }
            
            .compass-text { font-size: 0.95rem; line-height: 1.6; color: #e2e8f0; }
            </style>
            
            <script>
            (function(){
                window.setRoot = function(root) {
                    const needle = document.getElementById('needle');
                    const title = document.getElementById('compass-title');
                    const desc = document.getElementById('compass-desc');
                    const bar = document.getElementById('bar-accuracy');
                    
                    document.querySelectorAll('.root-btn').forEach(b => b.classList.remove('active'));
                    document.getElementById('btn-' + root).classList.add('active');
                    
                    if(root === 'emanation') { // North
                        needle.style.transform = "translate(-50%, -50%) rotate(0deg)";
                        title.innerText = "Root: Emanation (Atzilut)";
                        desc.innerText = "The soul of pure light. Their intuition is 100% aligned with truth. Signs point in the correct direction. However, they are fragile and can 'break' if exposed to impure environments.";
                        bar.style.width = "100%";
                        bar.style.background = "#4ade80"; // Green
                    } else if(root === 'creation') { // East
                        needle.style.transform = "translate(-50%, -50%) rotate(90deg)";
                        title.innerText = "Root: Creation (Beriah)";
                        desc.innerText = "The soul of intellect and prayer. Majority of signs point correctly. They thrive in meditation and study, avoiding heavy physical labor.";
                        bar.style.width = "75%";
                        bar.style.background = "#60a5fa"; // Blue
                    } else if(root === 'formation') { // West
                        needle.style.transform = "translate(-50%, -50%) rotate(270deg)";
                        title.innerText = "Root: Formation (Yetzirah)";
                        desc.innerText = "The soul of structure and emotion. Only a minority of signs point correctly. Often confused by the physical world. Needs strict adherence to law to navigate.";
                        bar.style.width = "40%";
                        bar.style.background = "#fbbf24"; // Yellow
                    } else { // South (Action)
                        needle.style.transform = "translate(-50%, -50%) rotate(180deg)";
                        title.innerText = "Root: Action (Asiyah)";
                        desc.innerText = "The physical soul. All spiritual indications are REVERSED. Their natural instincts lead them to materialism. They must constantly fight their nature to rise.";
                        bar.style.width = "10%";
                        bar.style.background = "#f87171"; // Red
                    }
                };
            })();
            </script>
            
            <h4>Peace with Conflict</h4>
            <p>By doing kindness (many times) one suffers, but one should know that suffering would have come upon him anyway, in a different form, except that by doing the kindness the judgement is weakened.</p>
            
            <h4>Techniques for Concentration</h4>
            <p>Learning heavy books which have to be done sitting down should be by making a pile of them on one side of the desk and doing the amount necessary and transferring them one by one to the opposite side of the desk. For lighter books one should lie down and hold them over his head so the blood rushes to the head and concentration is easier.</p>
            
            <h4>The Root of the Soul</h4>
            <p>The only way of telling if a "sign" is true is to go into your closet and meditate until hopefully you get the right answer. The reason for this is that each person has a root soul in Emanation, Creation, Formation, or the physical universe. Since each of these four worlds has varying degrees of evil, the indications also will vary.</p>
            
            <ul>
            <li><strong>Emanation:</strong> All indications point in the correct direction.</li>
            <li><strong>Creation:</strong> The majority point in the right direction.</li>
            <li><strong>Formation:</strong> The majority point in the <em>wrong</em> direction.</li>
            <li><strong>Action (Physical):</strong> All indications are in the wrong direction—which causes them to remain physical and never to try to rise above it.</li>
            </ul>
