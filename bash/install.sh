#!/bin/bash
set -e

CACHE_DIR="$HOME/.mvngen"
REPO_URL="https://github.com/rckukaswal/qa-maven-generator-cloudflare.git"
START_SCRIPT="$CACHE_DIR/bash/scripts/start.sh"

# Fresh install / reinstall
if [ -d "$CACHE_DIR" ]; then
    rm -rf "$CACHE_DIR"
fi

echo "⏳ Installing latest version..."

if git clone --depth 1 -q "$REPO_URL" "$CACHE_DIR" >/dev/null 2>&1; then
    echo "✅ Installed successfully"
else
    echo "❌ Installation failed. Check internet connection."
    exit 1
fi

if ! grep -q "alias rcmvn=" "$HOME/.bashrc"; then
    echo "alias rcmvn='bash \$HOME/.mvngen/bash/scripts/start.sh'" >> "$HOME/.bashrc"
    echo "✅ Alias 'rcmvn' added"
    echo "ℹ Run: source ~/.bashrc"
fi

bash "$START_SCRIPT"