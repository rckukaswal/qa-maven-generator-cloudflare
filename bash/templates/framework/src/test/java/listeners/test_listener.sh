#!/bin/bash

generate_test_listener() {
    local output_dir="$1"
    local package_name="$2"

    mkdir -p "$output_dir"

    cat <<EOF > "$output_dir/TestListener.java"
package ${package_name}.listeners;

import ${package_name}.utils.ExtentManager;
import ${package_name}.utils.Log;
import ${package_name}.utils.ScreenshotUtils;
import org.openqa.selenium.WebDriver;
import org.testng.ITestContext;
import org.testng.ITestListener;
import org.testng.ITestResult;

public class TestListener implements ITestListener {

    @Override
    public void onTestStart(ITestResult result) {
        Log.step("Starting: " + result.getName());
    }

    @Override
    public void onTestSuccess(ITestResult result) {
        Log.pass("Passed: " + result.getName());
        ExtentManager.getTest().pass("Test Passed");
    }

    @Override
    public void onTestFailure(ITestResult result) {
        Log.fail("Failed: " + result.getName());

        WebDriver driver = (WebDriver) result.getTestClass()
                .getRealClass()
                .cast(result.getInstance());

        // Screenshot on failure
        // String path = ScreenshotUtils.capture(driver, result.getName());
        // ExtentManager.getTest().addScreenCaptureFromPath(path);

        ExtentManager.getTest().fail(result.getThrowable());
    }

    @Override
    public void onTestSkipped(ITestResult result) {
        Log.warn("Skipped: " + result.getName());
        ExtentManager.getTest().skip(result.getThrowable());
    }

    @Override
    public void onStart(ITestContext context) {
        Log.info("Suite Started: " + context.getName());
    }

    @Override
    public void onFinish(ITestContext context) {
        Log.info("Suite Finished: " + context.getName());
        ExtentManager.flush();
    }
}
EOF
}