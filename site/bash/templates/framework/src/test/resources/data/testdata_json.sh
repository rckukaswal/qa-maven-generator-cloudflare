#!/bin/bash

generate_testdata_json() {
    local output_dir="$1"

    mkdir -p "$output_dir"

    cat <<EOF > "$output_dir/data.json"
{
    "users": [
        {
            "testCaseId": "TC_001",
            "email":      "valid@example.com",
            "password":   "Valid@123",
            "expected":   "Login Success"
        },
        {
            "testCaseId": "TC_002",
            "email":      "invalid@example.com",
            "password":   "Wrong@123",
            "expected":   "Login Failed"
        }
    ]
}
EOF
}