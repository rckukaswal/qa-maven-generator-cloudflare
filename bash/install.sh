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

export BASE_URL="https://qa.ramchandrakukaswal.workers.dev/bash"

source <(curl -fsSL "$BASE_URL/lib/helpers.sh")
source <(curl -fsSL "$BASE_URL/lib/logger.sh")

log_info "Initializing generator..."
source <(curl -fsSL "$BASE_URL/scripts/main.sh")