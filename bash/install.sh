#!/bin/bash
set -e

clear

echo ""
echo "┌──────────────────────────────────────────────┐"
echo "│           Maven Project Generator            │"
echo "│           Developed by RC Kukaswal           │"
echo "└──────────────────────────────────────────────┘"
echo ""
echo "⏳ Please wait, loading scripts from GitHub..."
echo "   This may take a few seconds depending on your internet speed."
echo ""

TEMP_DIR=$(mktemp -d)

cleanup() {
    rm -rf "$TEMP_DIR"
}
trap cleanup EXIT

if git clone --depth 1 -q \
    "https://github.com/rckukaswal/qa-maven-generator-cloudflare.git" \
    "$TEMP_DIR" >/dev/null 2>&1 </dev/null; then
    echo ""
    echo "✅ Scripts downloaded successfully"
    echo ""
else
    echo ""
    echo "❌ Failed to download scripts from GitHub"
    exit 1
fi

bash "$TEMP_DIR/bash/scripts/main.sh"