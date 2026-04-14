#!/bin/bash

check_maven() {
    if command_exists mvn; then
        log_success "Maven found: $(mvn -version 2>&1 | head -1)"
    else
        log_error "Maven not found — please install Maven 3.6+"
        exit 1
    fi
}