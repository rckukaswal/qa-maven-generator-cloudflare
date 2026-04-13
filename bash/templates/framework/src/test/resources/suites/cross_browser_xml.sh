#!/bin/bash

generate_cross_browser_suite() {
    local output_dir="$1"
    local package_name="$2"

    mkdir -p "$output_dir"

    cat <<EOF > "$output_dir/cross_browser.xml"
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE suite SYSTEM "https://testng.org/testng-1.0.dtd">

<suite name="Cross Browser Suite" verbose="1" parallel="tests" thread-count="3">

    <listeners>
        <listener class-name="${package_name}.listeners.TestListener"/>
    </listeners>

    <test name="Chrome Tests">
        <parameter name="browser" value="chrome"/>
        <parameter name="url"     value=""/>
        <classes>
            <class name="${package_name}.tests.AppTest"/>
        </classes>
    </test>

    <test name="Firefox Tests">
        <parameter name="browser" value="firefox"/>
        <parameter name="url"     value=""/>
        <classes>
            <class name="${package_name}.tests.AppTest"/>
        </classes>
    </test>

    <test name="Edge Tests">
        <parameter name="browser" value="edge"/>
        <parameter name="url"     value=""/>
        <classes>
            <class name="${package_name}.tests.AppTest"/>
        </classes>
    </test>

</suite>
EOF
}