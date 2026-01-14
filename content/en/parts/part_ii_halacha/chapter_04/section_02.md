---
title: "Chapter 4: Festivals — Section II"
part: "Part II — Halachah"
chapter: "Chapter 04"
prev: ""
next: ""
section_title: "⚕️ The Bio-Halachic Monitor"
---

<h4>The Physics of Fasting</h4>

<blockquote class="fancy-quote">
"One may eat roughly half the volume of an egg every four minutes." — The Law of Shiurim.
</blockquote>

<p>On Yom Kippur, the prohibition against eating is absolute (-karet-). However, for one whose life is in danger, the law provides a precise mechanism to sustain the body without violating the core "volume" of eating that defines the act. By eating smaller amounts over longer intervals, the act is legally "atomized"—it sustains life without constituting a "meal."</p>

<div class="interactive-element metabolic-monitor">
    <h3>⚕️ The Bio-Halachic Monitor</h3>
    <div class="monitor-dashboard">
        <div class="gauge-container">
            <svg viewBox="0 0 100 100" class="circle-gauge">
                <circle cx="50" cy="50" r="45" class="gauge-bg" />
                <circle cx="50" cy="50" r="45" class="gauge-progress" id="volume-ring" />
            </svg>
            <div class="gauge-value">
                <span id="volume-val">0</span>%
                <small>VOLUME</small>
            </div>
        </div>
        
        <div class="status-panel">
            <div class="status-row">
                <span>THRESHOLD:</span>
                <span id="threshold-status" class="status-safe">SAFE</span>
            </div>
            <div class="status-row">
                <span>TIMER:</span>
                <span id="cooldown-timer">00:00</span>
            </div>
            <div class="status-row">
                <span>STATUS:</span>
                <span id="halachic-status">PERMITTED</span>
            </div>
        </div>
    </div>
    
    <div class="monitor-controls">
        <button onclick="consume('food')" class="btn-intake">🍎 Consume 'Shiur' (30cc)</button>
        <button onclick="consume('meal')" class="btn-danger">🍔 Consume Meal (100cc)</button>
    </div>
</div>

<style>
.metabolic-monitor { background: #000; padding: 2rem; border-radius: 20px; margin: 3rem 0; color: #4ade80; border: 1px solid #111; box-shadow: 0 0 30px rgba(74, 222, 128, 0.1); font-family: 'share tech mono', monospace; text-align: center; }
.monitor-dashboard { display: flex; justify-content: space-around; align-items: center; margin-bottom: 2rem; flex-wrap: wrap; }

.gauge-container { width: 150px; height: 150px; position: relative; }
.circle-gauge { transform: rotate(-90deg); width: 100%; height: 100%; }
.gauge-bg { fill: none; stroke: #1e293b; stroke-width: 8; }
.gauge-progress { fill: none; stroke: #4ade80; stroke-width: 8; stroke-dasharray: 283; stroke-dashoffset: 283; transition: stroke-dashoffset 0.5s; }
.gauge-value { position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); display: flex; flex-direction: column; font-size: 1.5rem; font-weight: bold; }
.gauge-value small { font-size: 0.6rem; opacity: 0.7; }

.status-panel { text-align: left; background: #0f172a; padding: 1.5rem; border-radius: 8px; border: 1px solid #334155; min-width: 200px; }
.status-row { display: flex; justify-content: space-between; margin-bottom: 0.5rem; border-bottom: 1px solid #1e293b; padding-bottom: 0.2rem; }
.status-safe { color: #4ade80; }
.status-warning { color: #facc15; }
.status-danger { color: #f87171; }

.monitor-controls button { padding: 1rem 1.5rem; border: none; border-radius: 4px; font-family: inherit; font-weight: bold; cursor: pointer; transition: 0.3s; margin: 0 5px; }
.btn-intake { background: #1e293b; color: #4ade80; border: 1px solid #4ade80; }
.btn-intake:hover { background: #4ade80; color: #000; }
.btn-danger { background: #1e293b; color: #f87171; border: 1px solid #f87171; }
.btn-danger:hover { background: #f87171; color: #000; }

</style>

<script>
    let currentVolume = 0;
    let timer = 0;
    let interval;
    
    function consume(type) {
        const ring = document.getElementById('volume-ring');
        const val = document.getElementById('volume-val');
        const status = document.getElementById('halachic-status');
        const thresh = document.getElementById('threshold-status');
        
        if(type === 'food') {
            currentVolume += 30; // 30% arbitrary unit of "shiur"
        } else {
            currentVolume += 100;
        }
        
        // Update Ring
        // 283 is circumference
        const offset = 283 - (283 * (Math.min(currentVolume, 100) / 100));
        ring.style.strokeDashoffset = offset;
        val.innerText = currentVolume;
        
        // Logic
        if(currentVolume > 40) { // Limit roughly
            ring.style.stroke = "#f87171";
            status.innerHTML = "VIOLATION (KARET)";
            thresh.innerHTML = "CRITICAL";
            thresh.className = "status-danger";
            status.className = "status-danger";
        } else {
            ring.style.stroke = "#4ade80";
            status.innerHTML = "PERMITTED (Pikuach Nefesh)";
            thresh.innerHTML = "SAFE";
            thresh.className = "status-safe";
            status.className = "status-safe";
            
            // Start Cooldown if not violating
            startTimer();
        }
    }
    
    function startTimer() {
        if(interval) clearInterval(interval);
        timer = 9; // Simulating 9 minutes (scale down)
        
        interval = setInterval(() => {
            timer--;
            document.getElementById('cooldown-timer').innerText = "00:0" + timer;
            
            if(timer <= 0) {
                clearInterval(interval);
                currentVolume = 0; // Reset "Volume in stomach" simulation
                document.getElementById('volume-ring').style.strokeDashoffset = 283;
                document.getElementById('volume-val').innerText = 0;
                document.getElementById('halachic-status').innerText = "READY";
            }
        }, 1000);
    }
</script>

<h4>Prophetic Authority</h4>
<p>The Zohar states that the Second Day of Rosh Hashanah is not merely a custom of doubt but a "Long Day" (<em>Yoma Arichta</em>) decreed by the Prophets. This implies that even if we know the exact time of the New Moon, the spiritual necessity of the two-day judgment remains. The first day corresponds to severe judgment (<em>Din Kasha</em>), and the second to lenient judgment (<em>Din Rafya</em>), creating a complete circuit of divine evaluation.</p>

