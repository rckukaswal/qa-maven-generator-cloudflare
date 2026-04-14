#!/bin/bash

generate_app_test() {
    local output_dir="$1"
    local package_name="$2"

    mkdir -p "$output_dir"

    cat <<EOF > "$output_dir/AppTest.java"
package ${package_name}.tests;

import ${package_name}.base.BaseTest;
import ${package_name}.pages.AppPage;
import ${package_name}.utils.Log;
import org.testng.annotations.Test;

public class AppTest extends BaseTest {

    @Test
    public void sampleTest() {
        AppPage page = new AppPage(driver);

        String title = page.getTitle();
        Log.info("Page Title: " + title);

        // TODO: Add your test steps here
        // page.clickElement();
        // assertThat(title).contains("Expected Text");
    }
}
EOF
}