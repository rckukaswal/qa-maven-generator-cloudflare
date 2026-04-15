#!/bin/bash

command_exists() {
    command -v "$1" &> /dev/null
}

run_command() {
    "$@"
}

create_dir() {
    mkdir -p "$1"
}

copy_file() {
    cp "$1" "$2"
}

file_exists() {
    [[ -f "$1" ]]
}

dir_exists() {
    [[ -d "$1" ]]
}

confirm_prompt() {
    local message="${1:-Proceed?}"
    read -p "$message [Y/n] : " confirm </dev/tty
    confirm=${confirm:-Y}
    if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
        log_warning "Generation cancelled"
        exit 0
    fi
}
select_option() {
    local prompt="$1"
    shift
    local options=("$@")
    local selected=0
    local key
    local lines=${#options[@]}

    local CYAN='\033[0;36m'
    local BOLD='\033[1m'
    local RESET='\033[0m'
    local BLUE='\033[0;34m'
    local DIM='\033[2m'
    local WHITE='\033[1;37m'

    # heading only once
    echo ""
    echo -e "  ${BOLD}${BLUE}▶  ${WHITE}${prompt}${RESET}"
    echo -e "  ${DIM}$(printf '─%.0s' {1..36})${RESET}"

    # initial render
    for i in "${!options[@]}"; do
        if [[ $i -eq $selected ]]; then
            printf "${CYAN}${BOLD}❯ %s${RESET}\n" "${options[$i]}" >&2
        else
            printf "  %s\n" "${options[$i]}" >&2
        fi
    done

    while true; do
        read -rsn1 key </dev/tty

        case "$key" in
            $'\x1b')
                read -rsn2 key </dev/tty
                case "$key" in
                    "[A")
                        ((selected--))
                        [[ $selected -lt 0 ]] && selected=$((${#options[@]} - 1))
                        ;;
                    "[B")
                        ((selected++))
                        [[ $selected -ge ${#options[@]} ]] && selected=0
                        ;;
                esac

                # move cursor only over option lines
                for ((i=0; i<lines; i++)); do
                    tput cuu1 >&2
                done

                # clear + redraw options
                for i in "${!options[@]}"; do
                    tput el >&2
                    if [[ $i -eq $selected ]]; then
                        printf "${CYAN}${BOLD}❯ %s${RESET}\n" "${options[$i]}" >&2
                    else
                        printf "  %s\n" "${options[$i]}" >&2
                    fi
                done
                ;;
            "")
                printf '%s\n' "${options[$selected]}"
                return
                ;;
        esac
    done
}