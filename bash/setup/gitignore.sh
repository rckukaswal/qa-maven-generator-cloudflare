#!/bin/bash

create_gitignore() {
    local project_dir="$1"

    if [ -f "$project_dir/.gitignore" ]; then
        log_warning ".gitignore already exists. Skipping creation."
        return 0
    fi

    log_step "Creating .gitignore"

    cat <<'EOL' > "$project_dir/.gitignore"
# Maven build
target/
build/
out/

# Logs
*.log
logs/

# Reports
reports/
screenshots/
test-output/
surefire-reports/

# Test data / config
*.properties.local
.env
config.properties
credentials.properties

# OS files
.DS_Store
Thumbs.db

# IntelliJ
.idea/
*.iml

# Eclipse
.project
.classpath
.settings/

# VS Code
.vscode/

# NetBeans
nbproject/

# Java
*.class

# Archives
*.jar
*.war
*.ear
*.zip

# Temp
*.tmp
*.swp
*.bak

# Maven wrapper
.mvn/
mvnw
mvnw.cmd

# Node (optional)
node_modules/
EOL

    log_success ".gitignore created successfully."
}