#!/usr/bin/env bash
# Update deploy_symbol.json with a new symbol and timestamp
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
OUT_FILE="$ROOT_DIR/deploy_symbol.json"

# Emoji list to choose from (keeps it visible and varied)
EMOJIS=(🔵 🔴 🟢 🟡 ⚪ ⚫ 🔶 🔷 🔔 ✳️ ⭐️ ✨ 🔰 🛡️ 🧭 🕊️ 🔑 📝 🔎)

# Choose an index from current unix seconds to vary per run
TS=$(date +%s)
IDX=$((TS % ${#EMOJIS[@]}))
SYMBOL=${EMOJIS[$IDX]}

MSG="Deploy symbol updated: $SYMBOL (ts=$TS)"

cat > "$OUT_FILE" <<EOF
{
  "symbol": "$SYMBOL",
  "timestamp": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
  "message": "$MSG"
}
EOF

echo "$MSG"
