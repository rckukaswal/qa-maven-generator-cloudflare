#!/bin/bash

generate_env_properties() {
    local output_dir="$1"
    local test_url="$2"

    mkdir -p "$output_dir"

    cat <<EOF > "$output_dir/env.properties"
# ── Environments ───────────────────────────
# Active environment — change here to switch
env=qa

# ── QA ─────────────────────────────────────
qa.url=${test_url}
qa.browser=chrome

# ── Staging ────────────────────────────────
staging.url=
staging.browser=chrome

# ── Production ─────────────────────────────
prod.url=
prod.browser=chrome
EOF
}