#!/bin/bash

check_java() {
    if command_exists java; then
        log_success "Java found: $(java -version 2>&1 | head -1)"
    else
        log_error "Java not found — please install Java 17 or 21"
        exit 1
    fi
}