#!/bin/bash
set -e

BASE_DIR="$(cd "$(dirname "$0")/.." && pwd)"

# Common
source "$BASE_DIR/lib/helpers.sh"
source "$BASE_DIR/lib/logger.sh"

# Input
source "$BASE_DIR/scripts/input.sh"

# Setup
source "$BASE_DIR/setup/java.sh"
source "$BASE_DIR/setup/maven.sh"
source "$BASE_DIR/setup/git.sh"
source "$BASE_DIR/setup/gitignore.sh"

# Templates / Generator
source "$BASE_DIR/templates/pom/builder.sh"
source "$BASE_DIR/templates/framework/builder.sh"
source "$BASE_DIR/templates/testng/testng.sh"

# Run Input
collect_user_input

# Dynamic Config
source "$BASE_DIR/config/$LEVEL.config"

log_step "Starting Maven Project Generation"

# Project Generation
create_dir "$base_dir/$project_name"

build_pom
build_framework "$base_dir/$project_name" "$package_path" "$LEVEL"
generate_testng
create_gitignore

log_success "Project '$project_name' generated successfully!"

log_dim "Environment checks and setup in progress..."
# Environment Check
ensure_java 
ensure_maven 
ensure_git 
init_git_repo

# Summary
log_step "Project Summary"

printf "  %-14s : %s\n" "Level" "$LEVEL"
printf "  %-14s : %s\n" "Project Dir" "$base_dir/$project_name"

# Next Steps
echo "Next Steps:"
echo "   cd $project_name"
echo "   mvn test"
echo ""

echo "Available Suites:"
echo "   mvn test -DsuiteXmlFile=testng.xml"

if [[ "$LEVEL" == "intermediate" || "$LEVEL" == "advanced" ]]; then
    echo "   mvn test -DsuiteXmlFile=src/test/resources/suites/smoke.xml"
    echo "   mvn test -DsuiteXmlFile=src/test/resources/suites/regression.xml"
fi

if [[ "$LEVEL" == "advanced" ]]; then
    echo "   mvn test -DsuiteXmlFile=src/test/resources/suites/cross_browser.xml"
fi

echo ""