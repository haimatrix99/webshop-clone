FROM maven:3.8.4-openjdk-11 AS build

# Set the working directory
WORKDIR /app

# Copy the entire project
COPY . /app/WebShop
COPY ./webshop.sql /app/webshop.sql

# Create a minimal Maven project structure if not already exist
RUN mkdir -p /app/WebShop/src/main/webapp/WEB-INF
RUN if [ ! -f /app/WebShop/pom.xml ]; then \
    echo '<?xml version="1.0" encoding="UTF-8"?>\
    <project xmlns="http://maven.apache.org/POM/4.0.0"\
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"\
    xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">\
    <modelVersion>4.0.0</modelVersion>\
    <groupId>com.webshop</groupId>\
    <artifactId>WebShop</artifactId>\
    <version>1.0-SNAPSHOT</version>\
    <packaging>war</packaging>\
    <properties>\
    <maven.compiler.source>11</maven.compiler.source>\
    <maven.compiler.target>11</maven.compiler.target>\
    <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>\
    </properties>\
    <dependencies>\
    <dependency>\
    <groupId>javax.servlet</groupId>\
    <artifactId>javax.servlet-api</artifactId>\
    <version>4.0.1</version>\
    <scope>provided</scope>\
    </dependency>\
    <dependency>\
    <groupId>javax.servlet.jsp</groupId>\
    <artifactId>javax.servlet.jsp-api</artifactId>\
    <version>2.3.3</version>\
    <scope>provided</scope>\
    </dependency>\
    <dependency>\
    <groupId>mysql</groupId>\
    <artifactId>mysql-connector-java</artifactId>\
    <version>8.0.27</version>\
    </dependency>\
    <dependency>\
    <groupId>jstl</groupId>\
    <artifactId>jstl</artifactId>\
    <version>1.2</version>\
    </dependency>\
    <dependency>\
    <groupId>com.google.code.gson</groupId>\
    <artifactId>gson</artifactId>\
    <version>2.8.2</version>\
    </dependency>\
    <dependency>\
    <groupId>org.apache.httpcomponents</groupId>\
    <artifactId>httpclient</artifactId>\
    <version>4.5.5</version>\
    </dependency>\
    <dependency>\
    <groupId>org.apache.httpcomponents</groupId>\
    <artifactId>fluent-hc</artifactId>\
    <version>4.5.5</version>\
    </dependency>\
    <dependency>\
    <groupId>com.restfb</groupId>\
    <artifactId>restfb</artifactId>\
    <version>2.3.0</version>\
    </dependency>\
    </dependencies>\
    <build>\
    <plugins>\
    <plugin>\
    <groupId>org.apache.maven.plugins</groupId>\
    <artifactId>maven-war-plugin</artifactId>\
    <version>3.3.2</version>\
    <configuration>\
    <failOnMissingWebXml>false</failOnMissingWebXml>\
    </configuration>\
    </plugin>\
    </plugins>\
    </build>\
    </project>' > /app/WebShop/pom.xml; \
    fi

# Build the application
WORKDIR /app/WebShop
RUN mvn clean package

# Second stage: Runtime
FROM tomcat:9.0-jdk11-openjdk-slim

# Remove default applications
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy the built WAR file from the build stage
COPY --from=build /app/WebShop/target/WebShop-1.0-SNAPSHOT.war /usr/local/tomcat/webapps/ROOT.war

# Add MySQL JDBC driver
COPY --from=build /app/WebShop/src/main/webapp/WEB-INF/lib/mysql-connector-java-8.0.27.jar /usr/local/tomcat/lib/

# Create directory for custom Tomcat configurations if needed
RUN mkdir -p /usr/local/tomcat/conf/Catalina/localhost/

# Set environment variables with defaults (can be overridden when running the container)
ENV DB_HOST=mysql \
    DB_PORT=3306 \
    DB_NAME=webshop \
    DB_USER=root \
    DB_PASSWORD=

# Expose the default Tomcat port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"] 