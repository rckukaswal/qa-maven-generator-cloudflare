#!/bin/bash

# Colors & Styles
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
DIM='\033[2m'
BOLD='\033[1m'
RESET='\033[0m'

# Symbols
TICK="✔"
CROSS="✖"
ARROW="▶"
INFO="ℹ"
WARN="⚠"
DOT="•"

# Logging
log_info() {
    echo -e "  ${CYAN}${INFO}  ${WHITE}$1${RESET}"
}

log_success() {
    echo -e "  ${GREEN}${TICK}  ${WHITE}$1${RESET}"
}

log_warning() {
    echo -e "  ${YELLOW}${WARN}  ${WHITE}$1${RESET}"
}

log_error() {
    echo -e "  ${RED}${CROSS}  ${WHITE}$1${RESET}" >&2
}

log_step() {
    echo ""
    echo -e "  ${BOLD}${BLUE}${ARROW}  ${WHITE}$1${RESET}"
    #echo -e "  ${DIM}$(printf '─%.0s' {1..42})${RESET}"
}

log_dim() {
    echo -e "  ${DIM}${DOT}  $1${RESET}"
}