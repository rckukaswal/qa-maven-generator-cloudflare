#!/bin/bash

generate_testdata_excel() {
    local output_dir="$1"

    mkdir -p "$output_dir"

    curl -fsSL "$BASE_URL/templates/framework/src/test/resources/data/testdata.xlsx" \
        -o "$output_dir/testdata.xlsx"

    if [[ ! -f "$output_dir/testdata.xlsx" ]]; then
        log_error "testdata.xlsx download failed"
        return 1
    fi

    log_info "testdata.xlsx downloaded"
}