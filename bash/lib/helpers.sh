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

    # Colors
    local CYAN='\033[0;36m'
    local BOLD='\033[1m'
    local RESET='\033[0m'

    printf "%s\n" "$prompt" >&2
    for i in "${!options[@]}"; do
        printf "  %s\n" "${options[$i]}" >&2
    done

    while true; do
        for ((i=0; i<lines+1; i++)); do
            tput cuu1 >&2
            tput el >&2
        done

        printf "%s\n" "$prompt" >&2
        for i in "${!options[@]}"; do
            if [[ $i -eq $selected ]]; then
                printf "${CYAN}${BOLD}❯ %s${RESET}\n" "${options[$i]}" >&2
            else
                printf "  %s\n" "${options[$i]}" >&2
            fi
        done

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
                ;;
            "")
                printf '%s\n' "${options[$selected]}"
                return
                ;;
        esac
    done
}