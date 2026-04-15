check_git() {
    if command_exists git; then
        local git_version
        git_version=$(git --version 2>&1 | sed -n '1p')
        log_success "Git found: $git_version"
        return 0
    fi
    return 1
}

install_git() {
    log_info "Installing Git..."
    sudo apt update && sudo apt install -y git
}

ensure_git() {
    if check_git; then
        return 0
    fi

    log_warning "Git not found"

    if skip_prompt "Git is required. Install now?"; then
        install_git

        if check_git; then
            log_success "Git installed successfully"
            return 0
        fi

        log_error "Git installation failed"
        return 1
    fi

    log_warning "Skipping Git installation"
    return 1
}

init_git_repo() {
    if git init -b main "$base_dir/$project_name" >/dev/null 2>&1; then
        log_info "Git initialized in $project_name [main]"
    else
        git init "$base_dir/$project_name" >/dev/null 2>&1
        git -C "$base_dir/$project_name" branch -M main >/dev/null 2>&1
        log_info "Git initialized in $project_name [main]"
    fi
}