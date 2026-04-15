#!/bin/bash

create_gitignore() {
    local gitignore_file="$base_dir/$project_name/.gitignore"

    mkdir -p "$(dirname "$gitignore_file")"

    if [ -f "$gitignore_file" ]; then
        log_warning ".gitignore already exists. Skipping creation."
        return 0
    fi


    cat <<'EOL' > "$gitignore_file"
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

    log_success ".gitignore generated"
}