#!/bin/bash

generate_app_page() {
    local output_dir="$1"
    local package_name="$2"

    mkdir -p "$output_dir"

    cat <<EOF > "$output_dir/AppPage.java"
package ${package_name}.pages;

import org.openqa.selenium.WebDriver;

public class AppPage extends BasePage {

    public AppPage(WebDriver driver) {
        super(driver);
    }

    // TODO: Add your page elements here
    // @FindBy(id = "element-id")
    // private WebElement element;

    // TODO: Add your page methods here
    // public void clickElement() {
    //     click(element);
    // }
}
EOF
}