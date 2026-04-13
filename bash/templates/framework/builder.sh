#!/bin/bash

# ─────────────────────────────────────────
#  Framework Builder
# ─────────────────────────────────────────

build_framework() {
    local project_dir="$1"
    local package_path="$2"
    local level="$3"

    log_step "Building Framework [$level]"

    # Source all template files
    source <(curl -fsSL "$BASE_URL/templates/framework/src/main/java/factory/driver_factory.sh")
    source <(curl -fsSL "$BASE_URL/templates/framework/src/main/java/pages/base_page.sh")
    source <(curl -fsSL "$BASE_URL/templates/framework/src/main/java/pages/app_page.sh")
    source <(curl -fsSL "$BASE_URL/templates/framework/src/main/java/utils/log_utils.sh")
    source <(curl -fsSL "$BASE_URL/templates/framework/src/main/java/utils/wait_utils.sh")
    source <(curl -fsSL "$BASE_URL/templates/framework/src/main/java/utils/screenshot_utils.sh")
    source <(curl -fsSL "$BASE_URL/templates/framework/src/main/java/utils/extent_manager.sh")
    source <(curl -fsSL "$BASE_URL/templates/framework/src/main/java/utils/excel_utils.sh")
    source <(curl -fsSL "$BASE_URL/templates/framework/src/test/java/base/base_test.sh")
    source <(curl -fsSL "$BASE_URL/templates/framework/src/test/java/tests/app_test.sh")
    source <(curl -fsSL "$BASE_URL/templates/framework/src/test/java/listeners/test_listener.sh")
    source <(curl -fsSL "$BASE_URL/templates/framework/src/test/resources/suites/smoke_suite_xml.sh")
    source <(curl -fsSL "$BASE_URL/templates/framework/src/test/resources/suites/regression_suite_xml.sh")
    source <(curl -fsSL "$BASE_URL/templates/framework/src/test/resources/suites/cross_browser_xml.sh")
    source <(curl -fsSL "$BASE_URL/templates/framework/src/test/resources/data/test_config_properties.sh")
    source <(curl -fsSL "$BASE_URL/templates/framework/src/test/resources/data/testdata_excel.sh")
    source <(curl -fsSL "$BASE_URL/templates/framework/src/test/resources/data/testdata_json.sh")
    source <(curl -fsSL "$BASE_URL/templates/framework/src/test/resources/data/users_csv.sh")
    source <(curl -fsSL "$BASE_URL/templates/framework/src/main/resources/config_properties.sh")
    source <(curl -fsSL "$BASE_URL/templates/framework/src/main/resources/log4j2_xml.sh")
    source <(curl -fsSL "$BASE_URL/templates/framework/src/main/resources/locators_json.sh")
    source <(curl -fsSL "$BASE_URL/templates/framework/src/main/resources/env_properties.sh")
    source <(curl -fsSL "$BASE_URL/templates/framework/src/main/resources/messages_properties.sh")

    create_framework_folders "$project_dir" "$package_path"
    generate_framework_files "$project_dir" "$package_path" "$level"

    log_success "Framework generated"
}

# ─────────────────────────────────────────
#  Step 1 — Folders banana
# ─────────────────────────────────────────

create_framework_folders() {
    local project_dir="$1"
    local package_path="$2"

    local main_java="$project_dir/src/main/java/$package_path"
    local main_res="$project_dir/src/main/resources"
    local test_java="$project_dir/src/test/java/$package_path"
    local test_res="$project_dir/src/test/resources"

    # main/java
    mkdir -p "$main_java/factory"
    mkdir -p "$main_java/pages"
    mkdir -p "$main_java/utils"

    # main/resources
    mkdir -p "$main_res"

    # test/java
    mkdir -p "$test_java/base"
    mkdir -p "$test_java/tests"
    mkdir -p "$test_java/listeners"

    # test/resources
    mkdir -p "$test_res/suites"
    mkdir -p "$test_res/data"

    log_info "Folders created"
}

# ─────────────────────────────────────────
#  Step 2 — Files generate karna
# ─────────────────────────────────────────

generate_framework_files() {
    local project_dir="$1"
    local package_path="$2"
    local level="$3"

    local package_name
    package_name=$(echo "$package_path" | tr '/' '.')

    local main_java="$project_dir/src/main/java/$package_path"
    local main_res="$project_dir/src/main/resources"
    local test_java="$project_dir/src/test/java/$package_path"
    local test_res="$project_dir/src/test/resources"

    # ── Always generate (Beginner + above) ──

    generate_driver_factory  "$main_java/factory"   "$package_name"
    generate_base_page       "$main_java/pages"     "$package_name"
    generate_app_page        "$main_java/pages"     "$package_name"
    generate_base_test       "$test_java/base"      "$package_name"  "$TEST_URL"
    generate_app_test        "$test_java/tests"     "$package_name"
    generate_config_properties "$test_res/data"     "$TEST_URL"
    generate_testdata_excel  "$test_res/data"
    generate_testdata_json   "$test_res/data"
    generate_smoke_suite     "$test_res/suites"     "$package_name"

    # ── Intermediate + Advanced ──

    if [[ "$level" == "intermediate" || "$level" == "advanced" ]]; then
        generate_log_utils        "$main_java/utils"   "$package_name"
        generate_wait_utils       "$main_java/utils"   "$package_name"
        generate_screenshot_utils "$main_java/utils"   "$package_name"
        generate_extent_manager   "$main_java/utils"   "$package_name"
        generate_excel_utils      "$main_java/utils"   "$package_name"
        generate_test_listener    "$test_java/listeners" "$package_name"
        generate_regression_suite "$test_res/suites"   "$package_name"
        generate_log4j2_xml       "$main_res"
        generate_users_csv        "$test_res/data"
    fi

    # ── Advanced only ──

    if [[ "$level" == "advanced" ]]; then
        generate_env_properties   "$main_res"          "$TEST_URL"
        generate_locators_json    "$main_res"
        generate_messages_properties "$main_res"
        generate_cross_browser_suite "$test_res/suites" "$package_name"
    fi
}