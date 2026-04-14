#!/bin/bash

generate_driver_factory() {
    local output_dir="$1"
    local package_name="$2"

    mkdir -p "$output_dir"

    cat <<EOF > "$output_dir/DriverFactory.java"
package ${package_name}.factory;

import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.edge.EdgeDriver;
import org.openqa.selenium.firefox.FirefoxDriver;
import io.github.bonigarcia.wdm.WebDriverManager;

public class DriverFactory {

    public static WebDriver getDriver(String browser) {
        switch (browser.toLowerCase()) {

            /*
             * Chrome with options — uncomment if needed
             *
             * case "chrome":
             *     ChromeOptions options = new ChromeOptions();
             *     options.addArguments("--headless=new");
             *     return new ChromeDriver(options);
             */

            case "chrome":
                return new ChromeDriver();

            case "firefox":
                WebDriverManager.firefoxdriver().setup();
                return new FirefoxDriver();

            case "edge":
                WebDriverManager.edgedriver().setup();
                return new EdgeDriver();

            default:
                throw new IllegalArgumentException("Invalid browser: " + browser);
        }
    }
}
EOF
}