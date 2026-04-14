#!/bin/bash

generate_base_test() {
    local output_dir="$1"
    local package_name="$2"
    local test_url="$3"

    mkdir -p "$output_dir"

    cat <<EOF > "$output_dir/BaseTest.java"
package ${package_name}.base;

import ${package_name}.factory.DriverFactory;
import ${package_name}.utils.ExtentManager;
import ${package_name}.utils.Log;
import org.openqa.selenium.WebDriver;
import org.testng.annotations.*;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.Properties;

public class BaseTest {

    protected WebDriver  driver;
    protected Properties config;

    @BeforeSuite
    public void loadConfig() throws IOException {
        config = new Properties();
        try (FileInputStream fis = new FileInputStream(
                "src/test/resources/data/config.properties")) {
            config.load(fis);
        }
        Log.info("Config loaded successfully");
    }

    @BeforeMethod
    @Parameters({"browser", "url"})
    public void setup(
            @Optional("chrome")         String browser,
            @Optional("${test_url}")    String url) {
        driver = DriverFactory.getDriver(browser);
        driver.manage().window().maximize();
        driver.get(url);
        Log.info("Browser launched: " + browser + " | URL: " + url);
        ExtentManager.createTest(browser + " | " + url);
    }

    @AfterMethod
    public void tearDown() {
        if (driver != null) {
            driver.quit();
            Log.info("Browser closed");
        }
    }

    @AfterSuite
    public void flushReport() {
        ExtentManager.flush();
        Log.info("Extent Report flushed");
    }
}
EOF
}