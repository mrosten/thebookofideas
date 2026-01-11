#!/usr/bin/env bash
set -euo pipefail

# Portable wrapper to run the PowerShell generator.
# Tries local `pwsh`, then falls back to the official PowerShell Docker image.

LANG_ARG="en"
if [ "$#" -ge 1 ]; then
  LANG_ARG="$1"
fi

SCRIPT="generate_website.ps1"

echo "Running website generator (Language=$LANG_ARG)..."

if command -v pwsh >/dev/null 2>&1; then
  echo "Using local pwsh"
  pwsh -NoProfile -NonInteractive -ExecutionPolicy Bypass -File "$SCRIPT" -Language "$LANG_ARG"
  exit $?
fi

if command -v docker >/dev/null 2>&1; then
  echo "pwsh not found — using PowerShell Docker image"
  docker run --rm -v "$PWD":/work -w /work mcr.microsoft.com/powershell:latest pwsh -NoProfile -NonInteractive -ExecutionPolicy Bypass -File "/work/$SCRIPT" -Language "$LANG_ARG"
  exit $?
fi

cat <<EOF
Neither 'pwsh' nor 'docker' found. Install PowerShell Core or Docker, or run this on a Windows machine with PowerShell.
Example (Ubuntu):
  sudo apt-get install -y powershell
  pwsh ./generate_website.ps1 -Language en
Or using Docker:
  docker run --rm -v "
  $(pwd)":/work -w /work mcr.microsoft.com/powershell:latest pwsh -File /work/generate_website.ps1 -Language en
EOF
exit 2
