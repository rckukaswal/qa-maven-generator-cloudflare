#!/bin/bash

collect_user_input() {
    log_info "Input Format Guide:"
    echo "  Project Name : company-purpose"
    echo "  Group ID     : domain.company"
    echo "  Base Package : domain.company.purpose"
    base_dir=$(pwd)

    # ----------- LEVEL INPUT -----------
    log_step "Choose Framework Level"
    level_label=$(select_option "" \
        "Beginner" \
        "Intermediate" \
        "Advanced")
    case "$level_label" in
        "Beginner")     LEVEL="beginner" ;;
        "Intermediate") LEVEL="intermediate" ;;
        "Advanced")     LEVEL="advanced" ;;
    esac

    # ----------- URL INPUT -----------
    log_step "Choose Base URL"
    url_label=$(select_option "" \
        "Google" \
        "Amazon" \
        "Custom")
    case "$url_label" in
        "Google") TEST_URL="https://www.google.com" ;;
        "Amazon") TEST_URL="https://www.amazon.in" ;;
        "Custom")
            read -p "Enter Custom URL [https://www.google.com] : " TEST_URL </dev/tty
            TEST_URL=${TEST_URL:-https://www.google.com}
            ;;
    esac

    # ----------- PROJECT DETAILS -----------
    log_step "Project Details"
    read -p "Enter Project Name [my-project] : " project_name </dev/tty
    project_name=${project_name:-my-project}
    project_name=$(echo "$project_name" | tr ' ' '-')

    while dir_exists "$base_dir/$project_name"; do
        log_warning "Project '$project_name' already exists"
        read -p "Enter a new project name [my-project] : " project_name </dev/tty
        project_name=${project_name:-my-project}
        project_name=$(echo "$project_name" | tr ' ' '-')
    done

    read -p "Enter Group ID [com.rc] : " group_id </dev/tty
    group_id=${group_id:-com.rc}

    default_package="$group_id.automation"
    read -p "Enter Base Package [$default_package] : " package_name </dev/tty
    package_name=${package_name:-$default_package}

    artifact_id="$project_name"
    package_path=$(echo "$package_name" | tr '.' '/')

    export LEVEL TEST_URL
    export project_name group_id artifact_id
    export package_name package_path base_dir

# ----------- SUMMARY -----------
log_step "Selected Configuration"

echo "  ┌──────────────────────────────────────────┐"
printf "  │ %-12s : %-28s │\n" "Level" "$LEVEL"
printf "  │ %-13s : %-28s │\n" "Base URL" "$TEST_URL"
printf "  │ %-13s : %-28s │\n" "Project" "$project_name"
printf "  │ %-13s : %-28s │\n" "Group ID" "$group_id"
printf "  │ %-13s : %-28s │\n" "Artifact" "$artifact_id"
printf "  │ %-13s : %-28s │\n" "Base Package" "$package_name"
echo "  └──────────────────────────────────────────┘"
    # ----------- CONFIRM -----------
    confirm_prompt "Proceed with generation?"
}