#!/bin/bash

generate_log4j2_xml() {
    local output_dir="$1"

    mkdir -p "$output_dir"

    cat <<EOF > "$output_dir/log4j2.xml"
<?xml version="1.0" encoding="UTF-8"?>
<Configuration status="WARN">

    <Appenders>

        <!-- Console Output -->
        <Console name="Console" target="SYSTEM_OUT">
            <PatternLayout pattern="%d{HH:mm:ss} [%-5level] %msg%n"/>
        </Console>

        <!-- File Output -->
        <RollingFile name="File"
                     fileName="test-output/logs/automation.log"
                     filePattern="test-output/logs/automation-%d{yyyy-MM-dd}.log">
            <PatternLayout pattern="%d{yyyy-MM-dd HH:mm:ss} [%-5level] %logger{36} - %msg%n"/>
            <Policies>
                <TimeBasedTriggeringPolicy interval="1"/>
            </Policies>
            <DefaultRolloverStrategy max="7"/>
        </RollingFile>

    </Appenders>

    <Loggers>
        <Root level="info">
            <AppenderRef ref="Console"/>
            <AppenderRef ref="File"/>
        </Root>
    </Loggers>

</Configuration>
EOF
}