#!/bin/bash
set -e

CACHE_DIR="$HOME/.mvngen"
REPO_URL="https://github.com/rckukaswal/qa-maven-generator-cloudflare.git"

# First time install
if [ ! -d "$CACHE_DIR" ]; then
    echo "⏳ First-time setup..."
    git clone --depth 1 -q "$REPO_URL" "$CACHE_DIR" >/dev/null 2>&1
    echo "✅ Installed successfully"

    # Add alias
    if ! grep -q "alias mvngen=" "$HOME/.bashrc"; then
        echo "alias mvngen='bash $CACHE_DIR/install.sh'" >> "$HOME/.bashrc"
        echo "✅ Alias 'mvngen' added"
        echo "ℹ Run: source ~/.bashrc"
    fi
else
    echo "⏳ Checking for updates..."

    if git -C "$CACHE_DIR" pull -q --ff-only >/dev/null 2>&1; then
        echo "✅ Updated to latest version"
    else
        echo "⚠ No network / update failed"
        echo "ℹ Running cached local version"
    fi
fi

bash "$CACHE_DIR/install.sh"