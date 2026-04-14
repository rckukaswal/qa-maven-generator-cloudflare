#!/bin/bash

generate_testng() {
    local suite_file="$base_dir/$project_name/testng.xml"

    mkdir -p "$(dirname "$suite_file")"

    local test_url="${TEST_URL:-https://www.google.com}"

    cat <<EOF > "$suite_file"
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE suite SYSTEM "https://testng.org/testng-1.0.dtd">

<suite name="Automation Suite" verbose="1">

    <listeners>
        <listener class-name="${package_name}.listeners.TestListener"/>
    </listeners>

    <parameter name="browser" value="chrome"/>
    <parameter name="url"     value="${test_url}"/>

    <test name="App Tests">
        <classes>
            <class name="${package_name}.tests.AppTest"/>
        </classes>
    </test>

</suite>
EOF

    log_success "testng.xml generated"
}