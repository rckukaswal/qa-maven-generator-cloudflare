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

git clone --depth 1 https://github.com/rckukaswal/qa-maven-generator-cloudflare.git "$TEMP_DIR"

echo ""
echo "✅ Scripts downloaded successfully"
echo ""

bash "$TEMP_DIR/bash/scripts/main.sh"
