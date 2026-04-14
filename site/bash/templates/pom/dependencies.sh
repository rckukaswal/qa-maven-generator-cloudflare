#!/bin/bash

# Group Tags
BROWSER="<!-- Browser Automation -->"
TESTING="<!-- Testing Framework -->"
LOGGING="<!-- Logging -->"
REPORTING="<!-- Reporting -->"
DATA="<!-- Data Handling -->"
PDF="<!-- PDF Support -->"
API="<!-- API Testing -->"
DATABASE="<!-- Database -->"
MOBILE="<!-- Mobile Automation -->"
UTILITY="<!-- Utility -->"

# Browser
selenium="$BROWSER
<!-- Selenium Java | Core browser automation library -->
<dependency>
    <groupId>org.seleniumhq.selenium</groupId>
    <artifactId>selenium-java</artifactId>
    <version>\${selenium.version}</version>
</dependency>"

webdrivermanager="<!-- WebDriverManager | Auto driver setup -->
<dependency>
    <groupId>io.github.bonigarcia</groupId>
    <artifactId>webdrivermanager</artifactId>
    <version>\${webdrivermanager.version}</version>
</dependency>"

# Testing
testng="$TESTING
<!-- TestNG | Test execution framework -->
<dependency>
    <groupId>org.testng</groupId>
    <artifactId>testng</artifactId>
    <version>\${testng.version}</version>
    <scope>test</scope>
</dependency>"

assertj="<!-- AssertJ | Fluent assertions -->
<dependency>
    <groupId>org.assertj</groupId>
    <artifactId>assertj-core</artifactId>
    <version>\${assertj.version}</version>
    <scope>test</scope>
</dependency>"

junit="<!-- JUnit | Unit testing -->
<dependency>
    <groupId>org.junit.jupiter</groupId>
    <artifactId>junit-jupiter</artifactId>
    <version>\${junit.version}</version>
    <scope>test</scope>
</dependency>"

mockito="<!-- Mockito | Mocking framework -->
<dependency>
    <groupId>org.mockito</groupId>
    <artifactId>mockito-core</artifactId>
    <version>\${mockito.version}</version>
    <scope>test</scope>
</dependency>"

# Logging
log4j="$LOGGING
<!-- Log4j | Logging API -->
<dependency>
    <groupId>org.apache.logging.log4j</groupId>
    <artifactId>log4j-api</artifactId>
    <version>\${log4j.version}</version>
</dependency>"

logback="<!-- Logback | Logging implementation -->
<dependency>
    <groupId>ch.qos.logback</groupId>
    <artifactId>logback-classic</artifactId>
    <version>\${logback.version}</version>
</dependency>"

# Reporting
extent="$REPORTING
<!-- Extent Report | HTML reporting -->
<dependency>
    <groupId>com.aventstack</groupId>
    <artifactId>extentreports</artifactId>
    <version>\${extent.version}</version>
</dependency>"

allure="<!-- Allure | Advanced reporting -->
<dependency>
    <groupId>io.qameta.allure</groupId>
    <artifactId>allure-testng</artifactId>
    <version>\${allure.version}</version>
</dependency>"

# Data
poi="$DATA
<!-- Apache POI | Excel support -->
<dependency>
    <groupId>org.apache.poi</groupId>
    <artifactId>poi-ooxml</artifactId>
    <version>\${poi.version}</version>
</dependency>"

jackson="<!-- Jackson | JSON parser -->
<dependency>
    <groupId>com.fasterxml.jackson.core</groupId>
    <artifactId>jackson-databind</artifactId>
    <version>\${jackson.version}</version>
</dependency>"

gson="<!-- Gson | JSON support -->
<dependency>
    <groupId>com.google.code.gson</groupId>
    <artifactId>gson</artifactId>
    <version>\${gson.version}</version>
</dependency>"

# PDF
itext="$PDF
<!-- iText | PDF support -->
<dependency>
    <groupId>com.itextpdf</groupId>
    <artifactId>itext-core</artifactId>
    <version>\${itext.version}</version>
    <type>pom</type>
</dependency>"

pdfbox="<!-- PDFBox | PDF utilities -->
<dependency>
    <groupId>org.apache.pdfbox</groupId>
    <artifactId>pdfbox</artifactId>
    <version>\${pdfbox.version}</version>
</dependency>"

# API
restassured="$API
<!-- REST Assured | API automation -->
<dependency>
    <groupId>io.rest-assured</groupId>
    <artifactId>rest-assured</artifactId>
    <version>\${restassured.version}</version>
    <scope>test</scope>
</dependency>"

wiremock="<!-- WireMock | Mock server -->
<dependency>
    <groupId>org.wiremock</groupId>
    <artifactId>wiremock</artifactId>
    <version>\${wiremock.version}</version>
    <scope>test</scope>
</dependency>"

# Database
mysql="$DATABASE
<!-- MySQL | Database driver -->
<dependency>
    <groupId>com.mysql</groupId>
    <artifactId>mysql-connector-j</artifactId>
    <version>\${mysql.version}</version>
</dependency>"

postgres="<!-- PostgreSQL | Database driver -->
<dependency>
    <groupId>org.postgresql</groupId>
    <artifactId>postgresql</artifactId>
    <version>\${postgres.version}</version>
</dependency>"

# Mobile
appium="$MOBILE
<!-- Appium | Mobile automation -->
<dependency>
    <groupId>io.appium</groupId>
    <artifactId>java-client</artifactId>
    <version>\${appium.version}</version>
</dependency>"

# Utility
lombok="$UTILITY
<!-- Lombok | Boilerplate reduction -->
<dependency>
    <groupId>org.projectlombok</groupId>
    <artifactId>lombok</artifactId>
    <version>\${lombok.version}</version>
    <scope>provided</scope>
</dependency>"