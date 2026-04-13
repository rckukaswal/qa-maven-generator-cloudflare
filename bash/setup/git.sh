#!/bin/bash

check_git() {
    if command_exists git; then
        log_success "Git found: $(git --version)"
        git init "$base_dir/$project_name"
        log_info "Git initialized in $project_name"
    else
        log_error "Git not found — please install Git"
        exit 1
    fi
}