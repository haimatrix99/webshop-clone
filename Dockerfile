FROM maven:3.8.4-openjdk-11 AS build

# Set the working directory
WORKDIR /app

# Copy the entire project
COPY . /app/WebShop

# Create a minimal Maven project structure if not already exist
RUN mkdir -p /app/WebShop/src/main/webapp/WEB-INF

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