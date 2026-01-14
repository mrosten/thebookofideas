---
title: "Chapter 7: Saints — Section V"
part: "Part III — Life"
chapter: "Chapter 07"
prev: ""
next: ""
section_title: "The Miracle Test"
---

            

<blockquote class="fancy-quote">
            "If I am a man of God, let fire come down from heaven." — Elijah the Prophet.
            </blockquote>
            
            <!-- Interactive Visual: The Miracle Test -->
            <div class="interactive-element miracle-visual">
                <div class="miracle-container">
                    <div id="prophet-figure" class="figure visible"></div>
                    <div id="miracle-effect" class="effect"></div>
                </div>
                
                <div class="miracle-controls">
                    <button class="test-btn active" onclick="setTest('visible')" id="btn-visible">The Visible Saint (Miracles)</button>
                    <button class="test-btn" onclick="setTest('hidden')" id="btn-hidden">The Hidden Saint (Internal)</button>
                </div>
                
                <div class="miracle-readout" id="miracle-status">Type: VISIBLE. Validated by external alteration of nature.</div>
            </div>
            
            <style>
            .miracle-visual { background: var(--primary-deep); border-radius: var(--radius-lg); padding: 2.5rem; margin: 3rem 0; border: 1px solid rgba(197, 160, 89, 0.2); text-align: center; }
            
            .miracle-container { position: relative; height: 250px; background: #020617; border-radius: var(--radius-md); overflow: hidden; margin-bottom: 2rem; border: 1px solid #334155; }
            
            .figure { position: absolute; bottom: 0; left: 50%; width: 60px; height: 100px; background: #cbd5e1; transform: translateX(-50%); border-radius: 30px 30px 0 0; transition: all 0.5s; }
            .figure::after { content: ''; position: absolute; top: -20px; left: 10px; width: 40px; height: 40px; background: #cbd5e1; border-radius: 50%; }
            
            .effect { position: absolute; top: 0; left: 0; width: 100%; height: 100%; pointer-events: none; }
            
            /* Visible Mode */
            .visible-mode .figure { background: #fbbf24; box-shadow: 0 0 50px #fbbf24; }
            .visible-mode .effect::before { content: ''; position: absolute; top: -100px; left: 50%; transform: translateX(-50%); width: 20px; height: 300px; background: linear-gradient(to bottom, #f87171, transparent); animation: strike 0.2s infinite alternate; }
            @keyframes strike { 0% { opacity: 0.5; height: 200px; } 100% { opacity: 1; height: 300px; width: 50px; } }
            
            /* Hidden Mode */
            .hidden-mode .figure { background: #1e293b; opacity: 0.5; }
            .hidden-mode .effect::after { content: ''; position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); width: 10px; height: 10px; background: #fff; border-radius: 50%; box-shadow: 0 0 100px 20px rgba(255,255,255,0.2); animation: pulse-inner 3s infinite; }
            @keyframes pulse-inner { 0% { opacity: 0.2; transform: translate(-50%, -50%) scale(1); } 50% { opacity: 0.8; transform: translate(-50%, -50%) scale(5); } 100% { opacity: 0.2; transform: translate(-50%, -50%) scale(1); } }
            
            .miracle-controls { display: flex; justify-content: center; gap: 1rem; margin-bottom: 1.5rem; }
            
            .test-btn { background: rgba(255,255,255,0.05); border: 1px solid rgba(255,255,255,0.1); color: #cbd5e1; padding: 0.75rem 1.5rem; border-radius: var(--radius-md); cursor: pointer; transition: all 0.3s; font-family: monospace; }
            .test-btn:hover { background: rgba(255,255,255,0.1); }
            .test-btn.active { background: var(--accent-gold); color: #020617; border-color: var(--accent-gold); font-weight: 700; }
            
            .miracle-readout { font-family: monospace; color: #94a3b8; font-size: 0.9rem; }
            </style>
            
            <script>
            (function(){
                window.setTest = function(mode) {
                    const container = document.querySelector('.miracle-container');
                    const readout = document.getElementById('miracle-status');
                    
                    document.querySelectorAll('.test-btn').forEach(b => b.classList.remove('active'));
                    
                    if(mode === 'visible') {
                        container.classList.add('visible-mode');
                        container.classList.remove('hidden-mode');
                        document.getElementById('btn-visible').classList.add('active');
                        readout.innerText = "Type: VISIBLE. Validated by external alteration of nature.";
                        readout.style.color = "#f87171";
                    } else {
                        container.classList.add('hidden-mode');
                        container.classList.remove('visible-mode');
                        document.getElementById('btn-hidden').classList.add('active');
                        readout.innerText = "Type: HIDDEN. Accelerating towards God (Internal).";
                        readout.style.color = "#cbd5e1";
                    }
                };
                
                setTimeout(() => setTest('visible'), 100);
            })();
            </script>
            
            <h4>How to Tell if Someone is a Saint</h4>
            <p>Rabbi Yakov Abuchatzeira writes that if you see two people serving God, but one is full of miracles and the other is not, you should know the reason is because the one with the miracles is a greater saint than the other. As Eliyahu the Prophet said, “If I am a man of God let fire come down from heaven.” He made the test of his righteousness dependent on a miracle. This test would leave most present-day rabbis out in the cold.</p>
            
            <h4>The Missing Frequency</h4>
            <p>The reason some psychic people or even saints lack certain knowledge is that part of their soul is missing. Some can advise on everything until it comes to a monetary issue, where their love for it blinds them. This explains how Rabbi Akiva could decide that Bar Kochba was the Messiah—the "Messiah frequency" was missing in his radio, so he could not detect the static.</p>
            
            <h4>The Pessimism of the East</h4>
            <p>We are indebted to Hindu thinkers for the clarity of their belief that God is the only reality. Yet, the pessimism of their teachings—that human deeds are fruitless—stifled their civilization for 2000 years. The Jewish belief in the power of the Mind and the Christian belief in the power of Good Deeds shaped Western civilization. Here we have another example of why we must combine the paths.</p>
