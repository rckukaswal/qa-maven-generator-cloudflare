#!/bin/bash

source <(curl -fsSL "$BASE_URL/templates/pom/versions.sh")
source <(curl -fsSL "$BASE_URL/templates/pom/dependencies.sh")
source <(curl -fsSL "$BASE_URL/templates/pom/plugins.sh")
source <(curl -fsSL "$BASE_URL/templates/pom/render.sh")

properties=""
dependencies=""
plugins=""

property_flags=(
    "SELENIUM_VERSION:selenium.version"
    "WEBDRIVERMANAGER_VERSION:webdrivermanager.version"
    "TESTNG_VERSION:testng.version"
    "ASSERTJ_VERSION:assertj.version"
    "JUNIT_VERSION:junit.version"
    "MOCKITO_VERSION:mockito.version"
    "LOG4J_VERSION:log4j.version"
    "LOGBACK_VERSION:logback.version"
    "EXTENT_VERSION:extent.version"
    "ALLURE_VERSION:allure.version"
    "POI_VERSION:poi.version"
    "JACKSON_VERSION:jackson.version"
    "GSON_VERSION:gson.version"
    "ITEXT_VERSION:itext.version"
    "PDFBOX_VERSION:pdfbox.version"
    "RESTASSURED_VERSION:restassured.version"
    
    "WIREMOCK_VERSION:wiremock.version"
    "MYSQL_VERSION:mysql.version"
    "POSTGRES_VERSION:postgres.version"
    "APPIUM_VERSION:appium.version"
    "LOMBOK_VERSION:lombok.version"
    "MAVEN_COMPILER_PLUGIN_VERSION:maven.compiler.plugin.version"
    "MAVEN_SUREFIRE_PLUGIN_VERSION:maven.surefire.plugin.version"
    "MAVEN_FAILSAFE_PLUGIN_VERSION:maven.failsafe.plugin.version"
    "ALLURE_MAVEN_VERSION:allure.maven.version"
)

dependency_flags=(
    "SELENIUM:selenium"
    "WEBDRIVERMANAGER:webdrivermanager"
    "TESTNG:testng"
    "ASSERTJ:assertj"
    "JUNIT:junit"
    "MOCKITO:mockito"
    "LOG4J:log4j"
    "LOGBACK:logback"
    "EXTENT:extent"
    "ALLURE:allure"
    "POI:poi"
    "JACKSON:jackson"
    "GSON:gson"
    "ITEXT:itext"
    "PDFBOX:pdfbox"
    "RESTASSURED:restassured"
    "WIREMOCK:wiremock"
    "MYSQL:mysql"
    "POSTGRES:postgres"
    "APPIUM:appium"
    "LOMBOK:lombok"
)

plugin_flags=(
    "ENABLE_COMPILER_PLUGIN:compiler_plugin"
    "ENABLE_SUREFIRE_PLUGIN:surefire_plugin"
    "ENABLE_FAILSAFE_PLUGIN:failsafe_plugin"
    "ENABLE_ALLURE_PLUGIN:allure_plugin"
)

# Build properties
build_properties() {
    properties=""
    for item in "${property_flags[@]}"; do
        var_name="${item%%:*}"
        property_name="${item##*:}"
        if [[ -n "${!var_name}" ]]; then
            properties="$properties
        <$property_name>${!var_name}</$property_name>"
        fi
    done
}

# Build dependencies
build_dependencies() {
    dependencies=""
    for item in "${dependency_flags[@]}"; do
        flag_name="${item%%:*}"
        dep_name="${item##*:}"
        if [[ "${!flag_name}" == true ]]; then
            dependencies="$dependencies
${!dep_name}
"
        fi
    done
}

# Build plugins
build_plugins() {
    plugins=""
    for item in "${plugin_flags[@]}"; do
        flag_name="${item%%:*}"
        plugin_name="${item##*:}"
        if [[ "${!flag_name}" == true ]]; then
            plugins="$plugins
${!plugin_name}
"
        fi
    done
}

# Build POM
build_pom() {
    log_step "Generate POM"
    build_properties
    build_dependencies
    build_plugins
    generate_pom "$base_dir/$project_name"
    log_success "pom.xml generated"
}