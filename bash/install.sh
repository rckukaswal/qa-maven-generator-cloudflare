#!/bin/bash
set -e

CACHE_DIR="$HOME/.mvngen"
REPO_URL="https://github.com/rckukaswal/qa-maven-generator-cloudflare.git"
MAIN_SCRIPT="$CACHE_DIR/bash/scripts/main.sh"

echo ""
echo "┌──────────────────────────────────────────────┐"
echo "│           Maven Project Generator            │"
echo "│           Developed by RC Kukaswal           │"
echo "└──────────────────────────────────────────────┘"
echo ""

# First-time install
if [ ! -d "$CACHE_DIR/.git" ]; then
    echo "⏳ First-time setup..."

    if git clone --depth 1 -q "$REPO_URL" "$CACHE_DIR" >/dev/null 2>&1; then
        echo "✅ Installed successfully"

        # Add alias only once
        if ! grep -q "alias mvngen=" "$HOME/.bashrc"; then
            echo "alias mvngen='bash \$HOME/.mvngen/bash/install.sh'" >> "$HOME/.bashrc"
            echo "✅ Alias 'mvngen' added"
            echo "ℹ Run: source ~/.bashrc"
        fi
    else
        echo "❌ Installation failed. Check internet connection."
        exit 1
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

# Run main script
if [ -f "$MAIN_SCRIPT" ]; then
    bash "$MAIN_SCRIPT"
else
    echo "❌ Main script not found: $MAIN_SCRIPT"
    exit 1
fi