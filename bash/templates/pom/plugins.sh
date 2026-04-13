#!/bin/bash

# Group Tags
BUILD_PLUGIN="<!-- Build Plugins -->"
TEST_PLUGIN="<!-- Test Plugins -->"
REPORT_PLUGIN="<!-- Report Plugins -->"

compiler_plugin="$BUILD_PLUGIN
<!-- Maven Compiler Plugin | Compiles Java source code -->
<plugin>
    <groupId>org.apache.maven.plugins</groupId>
    <artifactId>maven-compiler-plugin</artifactId>
    <version>\${maven.compiler.plugin.version}</version>
    <configuration>
        <source>\${maven.compiler.source}</source>
        <target>\${maven.compiler.target}</target>
        <release>\${maven.compiler.release}</release>
    </configuration>
</plugin>"

surefire_plugin="$TEST_PLUGIN
<!-- Maven Surefire Plugin | Runs TestNG unit tests -->
<plugin>
    <groupId>org.apache.maven.plugins</groupId>
    <artifactId>maven-surefire-plugin</artifactId>
    <version>\${maven.surefire.plugin.version}</version>
    <configuration>
        <suiteXmlFiles>
            <suiteXmlFile>testng.xml</suiteXmlFile>
        </suiteXmlFiles>
    </configuration>
</plugin>"

failsafe_plugin="<!-- Maven Failsafe Plugin | Runs integration tests -->
<plugin>
    <groupId>org.apache.maven.plugins</groupId>
    <artifactId>maven-failsafe-plugin</artifactId>
    <version>\${maven.failsafe.plugin.version}</version>
</plugin>"

allure_plugin="$REPORT_PLUGIN
<!-- Allure Maven Plugin | Generates Allure reports -->
<plugin>
    <groupId>io.qameta.allure</groupId>
    <artifactId>allure-maven</artifactId>
    <version>\${allure.maven.version}</version>
</plugin>"