#!/bin/bash
set -e

BASE_DIR="$(cd "$(dirname "$0")/.." && pwd)"
source "$BASE_DIR/lib/logger.sh"

CACHE_DIR="$HOME/.mvngen"
REPO_URL="https://github.com/rckukaswal/qa-maven-generator-cloudflare.git"
MAIN_SCRIPT="$CACHE_DIR/bash/scripts/main.sh"

clear

echo ""
echo "┌──────────────────────────────────────────────┐"
echo "│           Maven Project Generator            │"
echo "│        Developed by Ramchandra Kukaswal      │"
echo "└──────────────────────────────────────────────┘"
echo ""

log_info "Checking for updates..."

TEMP_DIR=$(mktemp -d)

if git clone --depth 1 -q "$REPO_URL" "$TEMP_DIR" >/dev/null 2>&1; then
    rm -rf "$CACHE_DIR"
    mv "$TEMP_DIR" "$CACHE_DIR"
    log_success "Updated with fresh latest version"
    echo ""
else
    rm -rf "$TEMP_DIR"
    log_warning "No network / update failed"
    log_info "Running cached local version"
fi

bash "$MAIN_SCRIPT"