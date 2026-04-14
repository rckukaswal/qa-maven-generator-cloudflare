#!/bin/bash

generate_log_utils() {
    local output_dir="$1"
    local package_name="$2"

    mkdir -p "$output_dir"

    cat <<EOF > "$output_dir/Log.java"
package ${package_name}.utils;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

public class Log {

    private static final Logger logger = LogManager.getLogger(Log.class);

    public static void info(String message) {
        logger.info(message);
    }

    public static void warn(String message) {
        logger.warn(message);
    }

    public static void error(String message) {
        logger.error(message);
    }

    public static void step(String message) {
        logger.info("── STEP : " + message);
    }

    public static void pass(String message) {
        logger.info("✔ PASS  : " + message);
    }

    public static void fail(String message) {
        logger.error("✘ FAIL  : " + message);
    }
}
EOF
}