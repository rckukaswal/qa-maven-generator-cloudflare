#!/bin/bash

generate_locators_json() {
    local output_dir="$1"

    mkdir -p "$output_dir"

    cat <<EOF > "$output_dir/locators.json"
{
    "AppPage": {
        "heading":      {"by": "id",    "value": ""},
        "searchBox":    {"by": "name",  "value": ""},
        "submitButton": {"by": "xpath", "value": ""}
    }
}
EOF
}