#!/bin/bash
set -e

CACHE_DIR="$HOME/.mvngen"
REPO_URL="https://github.com/rckukaswal/qa-maven-generator-cloudflare.git"
MAIN_SCRIPT="$CACHE_DIR/bash/scripts/main.sh"

clear

echo ""
echo "┌──────────────────────────────────────────────┐"
echo "│           Maven Project Generator            │"
echo "│           Developed by RC Kukaswal           │"
echo "└──────────────────────────────────────────────┘"
echo ""

echo "⏳ Checking for updates..."

TEMP_DIR=$(mktemp -d)

if git clone --depth 1 -q "$REPO_URL" "$TEMP_DIR" >/dev/null 2>&1; then
    rm -rf "$CACHE_DIR"
    mv "$TEMP_DIR" "$CACHE_DIR"
    echo "✅ Updated with fresh latest version"
else
    rm -rf "$TEMP_DIR"
    echo "⚠ No network / update failed"
    echo "ℹ Running cached local version"
fi

bash "$MAIN_SCRIPT"