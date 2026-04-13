#!/bin/bash

generate_users_csv() {
    local output_dir="$1"

    mkdir -p "$output_dir"

    cat <<EOF > "$output_dir/users.csv"
testCaseId,email,password,expected
TC_001,valid@example.com,Valid@123,Login Success
TC_002,invalid@example.com,Wrong@123,Login Failed
TC_003,empty@example.com,,Login Failed
EOF
}