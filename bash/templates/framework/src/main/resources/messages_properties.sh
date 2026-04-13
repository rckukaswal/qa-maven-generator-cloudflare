#!/bin/bash

generate_messages_properties() {
    local output_dir="$1"

    mkdir -p "$output_dir"

    cat <<EOF > "$output_dir/messages.properties"
# ── Success Messages ───────────────────────
success.login=Login successful
success.logout=Logout successful
success.form.submit=Form submitted successfully

# ── Error Messages ─────────────────────────
error.login=Invalid email or password
error.field.required=This field is required
error.page.not.found=Page not found

# ── Validation Messages ────────────────────
validation.email=Please enter a valid email
validation.password=Password must be at least 8 characters
validation.empty.field=Field cannot be empty

# ── Info Messages ──────────────────────────
info.loading=Please wait, loading...
info.session.expired=Your session has expired
EOF
}