#!/bin/bash
set -e

BASE_DIR="$(cd "$(dirname "$0")/.." && pwd)"

# Common
source "$BASE_DIR/lib/helpers.sh"
source "$BASE_DIR/lib/logger.sh"

# Input
source "$BASE_DIR/scripts/input.sh"

# Run input
collect_user_input

# Dynamic Config
source "$BASE_DIR/config/$LEVEL.config"

# Setup
source "$BASE_DIR/setup/java.sh"
source "$BASE_DIR/setup/maven.sh"
source "$BASE_DIR/setup/git.sh"

# Templates / Generator
source "$BASE_DIR/templates/pom/builder.sh"
source "$BASE_DIR/templates/framework/builder.sh"
source "$BASE_DIR/templates/testng/testng.sh"
source "$BASE_DIR/setup/gitignore.sh"

log_step "Starting Maven Project Generation"

# Project Generation
create_dir "$base_dir/$project_name"

build_pom
build_framework "$base_dir/$project_name" "$package_path" "$LEVEL"
generate_testng

log_success "Project '$project_name' generated successfully!"
# Environment Check
create_gitignore
check_java
check_maven
check_git


echo ""
echo "  Level        : $LEVEL"
echo "  Project Dir  : $base_dir/$project_name"
echo ""
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