check_java() {
    if command_exists java; then
        local java_version
        java_version=$(java -version 2>&1 | sed -n '1p')
        log_success "Java found: $java_version"
        return 0
    fi
    return 1
}

install_java() {
    log_info "Installing Java..."
    sudo apt update && sudo apt install -y openjdk-21-jdk
}

ensure_java() {
    if check_java; then
        return 0
    fi

    log_warning "Java not found"

    if skip_prompt "Java is required. Install now?"; then
        install_java

        if check_java; then
            log_success "Java installed successfully"
            return 0
        fi

        log_error "Java installation failed"
        return 1
    fi

    log_warning "Skipping Java installation"
    return 1
}