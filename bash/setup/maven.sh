check_maven() {
    if command_exists mvn; then
        local mvn_version
        mvn_version=$(mvn -version 2>&1 | sed -n '1p')
        log_success "Maven found: $mvn_version"
        return 0
    fi
    return 1
}

install_maven() {
    log_info "Installing Maven..."
    sudo apt update && sudo apt install -y maven
}

ensure_maven() {
    if check_maven; then
        return 0
    fi

    log_warning "Maven not found"

    if skip_prompt "Maven is required. Install now?"; then
        install_maven

        if check_maven; then
            log_success "Maven installed successfully"
            return 0
        fi

        log_error "Maven installation failed"
        return 1
    fi

    log_warning "Skipping Maven installation"
    return 1
}