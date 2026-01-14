---
title: "Chapter 2: Christianity — Section II"
part: "Part VI — Christianity"
chapter: "Chapter 02"
section_title: "The Intermediary Paradox"
prev: ""
next: ""
---

            <h4>The Definition of Idolatry</h4>
            <p>If Christians are defined as "Proselytes of the Gate" rather than idolaters, we must define the boundary. In the old Kabbalah we find prayers addressed to the <em>Sephirot</em> (Divine traits). We find an Amora in the Talmud going to the grave of his father crying, "Save me! Save me!" from his enemies. We ask the angels for blessings on Friday night (<em>Shalom Aleichem</em>). At what point does praying to a trait of God constitute valid worship, while praying to a stone constitutes idolatry? Aren't they both creations?</p>

            <blockquote class="fancy-quote">
                "The prohibition of idolatry relies entirely on the intention." — The Law of the Heart.
            </blockquote>

            <!-- Interactive Visual: The Idolatry Detector -->
            <div class="interactive-element idolatry-detector">
                <div class="detector-screen">
                    <div class="target-object" id="target-object">
                        <span class="object-icon" id="obj-icon">🗿</span>
                        <div class="object-label" id="obj-label">Stone Image</div>
                    </div>
                    
                    <div class="intention-beam" id="intention-beam"></div>
                    
                    <div class="mind-state">
                        <span class="mind-icon">🧠</span>
                        <div class="thought-bubble" id="thought-bubble">"This stone has power of its own!"</div>
                    </div>
                </div>

                <div class="detector-controls">
                    <div class="control-row">
                        <label>Object of Focus:</label>
                        <select id="select-object" class="selector">
                            <option value="stone">Statue / Icon</option>
                            <option value="saint">Grave of Saint</option>
                            <option value="angel">Angel</option>
                            <option value="money">Money / Career</option>
                        </select>
                    </div>
                    <div class="control-row">
                        <label>Internal Belief (Intention):</label>
                        <input type="range" min="0" max="100" value="0" class="slider" id="intention-slider">
                        <div class="slider-labels">
                            <span>Independent Power</span>
                            <span>Manifestation of God</span>
                        </div>
                    </div>
                </div>

                <div class="detector-result" id="detector-result">
                    verdict: <span class="verdict-text text-danger">ACTUAL IDOLATRY</span>
                </div>
            </div>

            <style>
                .idolatry-detector { background: #0f172a; border: 1px solid #334155; border-radius: 12px; padding: 2rem; margin: 2rem 0; box-shadow: 0 10px 30px rgba(0,0,0,0.5); }
                .detector-screen { height: 200px; background: radial-gradient(circle at bottom, #1e293b 0%, #020617 80%); border-radius: 8px; position: relative; display: flex; justify-content: space-between; align-items: center; padding: 0 3rem; overflow: hidden; margin-bottom: 1.5rem; }
                
                .target-object, .mind-state { display: flex; flex-direction: column; align-items: center; z-index: 10; width: 100px; text-align: center; }
                .object-icon, .mind-icon { font-size: 3rem; margin-bottom: 0.5rem; transition: all 0.5s; }
                .object-label { font-size: 0.8rem; color: #94a3b8; font-family: monospace; }
                
                .intention-beam { position: absolute; left: 100px; right: 100px; top: 50%; height: 4px; background: #334155; transform: translateY(-50%); transition: all 0.3s; box-shadow: 0 0 10px rgba(255,255,255,0.1); }
                
                .thought-bubble { position: absolute; top: 20px; right: 20px; background: #fff; color: #000; padding: 0.5rem 1rem; border-radius: 20px 20px 2px 20px; font-size: 0.8rem; max-width: 150px; opacity: 0; transform: translateY(10px); transition: all 0.5s; }
                .mind-state:hover .thought-bubble { opacity: 1; transform: translateY(0); }
                
                .detector-controls { display: grid; gap: 1.5rem; background: rgba(255,255,255,0.03); padding: 1.5rem; border-radius: 8px; }
                .control-row { display: grid; gap: 0.5rem; }
                .control-row label { color: #cbd5e1; font-size: 0.9rem; font-weight: bold; }
                
                .selector { background: #1e293b; color: #fff; padding: 0.5rem; border: 1px solid #475569; border-radius: 4px; }
                .slider { width: 100%; height: 6px; background: #334155; border-radius: 3px; accent-color: #fca5a5; }
                .slider-labels { display: flex; justify-content: space-between; font-size: 0.7rem; color: #64748b; margin-top: 0.25rem; }
                
                .detector-result { text-align: center; font-family: monospace; font-size: 1.1rem; color: #94a3b8; margin-top: 1.5rem; padding-top: 1rem; border-top: 1px solid #334155; }
                .verdict-text { font-weight: bold; font-size: 1.3rem; margin-left: 0.5rem; }
                .text-danger { color: #ef4444; text-shadow: 0 0 10px rgba(239, 68, 68, 0.4); }
                .text-success { color: #4ade80; text-shadow: 0 0 10px rgba(74, 222, 128, 0.4); }
                .text-warning { color: #fbbf24; text-shadow: 0 0 10px rgba(251, 191, 36, 0.4); }
                
                /* States */
                .beam-connected { background: #ef4444; box-shadow: 0 0 20px #ef4444; height: 6px; }
                .beam-holy { background: #4ade80; box-shadow: 0 0 20px #4ade80; height: 2px; border-bottom: 2px dashed #fff; }
            </style>

            <script>
                (function() {
                    const slider = document.getElementById('intention-slider');
                    const select = document.getElementById('select-object');
                    const icon = document.getElementById('obj-icon');
                    const label = document.getElementById('obj-label');
                    const bubble = document.getElementById('thought-bubble');
                    const beam = document.getElementById('intention-beam');
                    const verdict = document.querySelector('.verdict-text');
                    
                    const objects = {
                        stone: { ico: "🗿", name: "Stone Image" },
                        saint: { ico: "👳‍♂️", name: "Grave of Saint" },
                        angel: { ico: "👼", name: "Angel" },
                        money: { ico: "💵", name: "Money / Career" }
                    };
                    
                    function update() {
                        const val = parseInt(slider.value);
                        const type = select.value;
                        const obj = objects[type];
                        
                        // Update UI
                        icon.innerText = obj.ico;
                        label.innerText = obj.name;
                        
                        // Logic
                        let isIdolatry = false;
                        let text = "";
                        let statusColor = "";
                        let beamClass = "";
                        
                        if (val < 30) {
                            // Independent Power
                            text = "ACTUAL IDOLATRY";
                            statusColor = "text-danger";
                            beamClass = "beam-connected";
                            bubble.innerText = `"This ${obj.name} can save me! It has power!"`;
                            slider.style.accentColor = "#ef4444";
                        } else if (val < 70) {
                            // Mixed / Confusion
                            text = "CONFUSED / DANGEROUS";
                            statusColor = "text-warning";
                            beamClass = "";
                            bubble.innerText = `"God put power in this ${obj.name}, so I ask it."`;
                            slider.style.accentColor = "#fbbf24";
                        } else {
                            // Manifestation
                            text = "PERMISSIBLE (" + (type === 'money' ? 'Theoretically' : 'Holy') + ")";
                            statusColor = "text-success";
                            beamClass = "beam-holy";
                            bubble.innerText = `"God is everywhere, appearing now as ${obj.name}."`;
                            slider.style.accentColor = "#4ade80";
                        }
                        
                        // Special Case: Money
                        if (type === 'money' && val < 50) {
                             text = "MODERN IDOLATRY";
                             bubble.innerText = `"I need money to survive. It is my source."`;
                        }
                        
                        verdict.innerText = text;
                        verdict.className = "verdict-text " + statusColor;
                        beam.className = "intention-beam " + beamClass;
                    }
                    
                    slider.addEventListener('input', update);
                    select.addEventListener('change', update);
                    update(); // Init
                })();
            </script>

            <h4>The Rambam's Hard Line</h4>
            <p>The Rambam explains that the prohibition on idolatry refers to how it originally started: the generation of Enosh saw the stars in Heaven and reasoned that since God honored these creations, it was right to honor them too. Eventually, this devolved into worshiping them as independent powers.</p>
            <p><strong>The Legal Nuance:</strong> If one prays to something thinking of it as a separate power, it is idolatry. But if he prays knowing it is only a <em>manifestation</em> of God, it is not. Even finding Rava in the Gemara (and the Rambam rules this way) stating: if one bows to a statue out of fear or love, but does not accept it as a god, he has not transgressed the capital crime of idolatry.</p>

            <div class="highlight-box">
                <strong>Why Christians aren't Idolaters:</strong>
                <p>This explains why many early authorities held that Christians are not idol worshipers. Conversely, it explains why the **Desire for Money** is considered actual idolatry by the Chassidic masters. People trust money as an independent power ("If I have money, I am safe"). A Catholic praying to a statue often has a purer intent (seeing it as a representative of the One God) than a businessman trusting in his bank account.</p>
            </div>

            <h4>The Middleman Debate</h4>
            <p>However, the Rambam holds a stricter philosophical view: thinking one <em>needs</em> a middleman is itself a form of error. For the Rambam, the great evil of idolatry is <strong>Falsehood</strong>. Making a mistake about God is worse than making a mistake about physics. Yet, even the Rambam posits the "Active Intellect" as a channel between man and God. In practice, Jews everywhere go to holy men for blessings, ask angels for protection, and kiss the Torah scroll—not because the scroll is God, but because God has placed His Name there.</p>
