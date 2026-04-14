#!/bin/bash

generate_pom() {
    local project_dir="$1"

    cat <<EOF > "$project_dir/pom.xml"
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0
         https://maven.apache.org/xsd/maven-4.0.0.xsd">

    <modelVersion>4.0.0</modelVersion>

    <groupId>${group_id}</groupId>
    <artifactId>${artifact_id}</artifactId>
    <version>1.0-SNAPSHOT</version>
    <packaging>jar</packaging>

    <properties>
        <maven.compiler.source>${JAVA_VERSION}</maven.compiler.source>
        <maven.compiler.target>${JAVA_VERSION}</maven.compiler.target>
        <maven.compiler.release>${JAVA_VERSION}</maven.compiler.release>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
        <project.reporting.outputEncoding>UTF-8</project.reporting.outputEncoding>
${properties:-}
    </properties>

    <dependencies>
${dependencies:-}
    </dependencies>

    <build>
        <plugins>
${plugins:-}
        </plugins>
    </build>

</project>
EOF
}