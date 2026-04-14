#!/bin/bash

generate_testdata_excel() {
    local output_dir="$1"
    local source_file="$BASE_DIR/templates/framework/src/test/resources/data/testdata.xlsx"

    mkdir -p "$output_dir"

    cp "$source_file" "$output_dir/testdata.xlsx"

    if [[ ! -f "$output_dir/testdata.xlsx" ]]; then
        log_error "testdata.xlsx copy failed"
        return 1
    fi

    log_info "testdata.xlsx copied"
}
