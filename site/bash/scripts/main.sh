#!/bin/bash
set -e

export BASE_URL="https://qa.ramchandrakukaswal.workers.dev/bash"

# Common
source <(curl -fsSL "$BASE_URL/lib/helpers.sh")
source <(curl -fsSL "$BASE_URL/lib/logger.sh")

# Input
source <(curl -fsSL "$BASE_URL/scripts/input.sh")

# Run input
collect_user_input

# Dynamic Config
source <(curl -fsSL "$BASE_URL/config/$LEVEL.config")

# Setup
source <(curl -fsSL "$BASE_URL/setup/java.sh")
source <(curl -fsSL "$BASE_URL/setup/maven.sh")
source <(curl -fsSL "$BASE_URL/setup/git.sh")

# Templates / Generator
source <(curl -fsSL "$BASE_URL/templates/pom/builder.sh")
source <(curl -fsSL "$BASE_URL/templates/framework/builder.sh")
source <(curl -fsSL "$BASE_URL/templates/testng/testng.sh")

log_step "Starting Maven Project Generation"

# Environment Check
check_java
check_maven
check_git

# Project Generation
create_dir "$base_dir/$project_name"

build_pom
build_framework "$base_dir/$project_name" "$package_path" "$LEVEL"
generate_testng

log_success "Project '$project_name' generated successfully!"

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