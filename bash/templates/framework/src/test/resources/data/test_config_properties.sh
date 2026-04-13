#!/bin/bash

generate_config_properties() {
    local output_dir="$1"
    local test_url="$2"

    mkdir -p "$output_dir"

    cat <<EOF > "$output_dir/config.properties"
# Browser Configuration
browser=chrome
url=${test_url}

# Login Credentials
email=your-email@example.com
password=your-password

# Timeouts
implicit.wait=10
explicit.wait=15
page.load.timeout=30

# Reports
report.path=test-output/ExtentReport.html
screenshot.path=test-output/screenshots/
EOF
}