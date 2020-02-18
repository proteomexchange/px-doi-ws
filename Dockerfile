# Build stage
FROM maven:3.3.9-jdk-8-alpine AS build-env

# Create app directory
WORKDIR /px-doi-ws

COPY src ./src
COPY pom.xml ./
COPY config/application.yml ./application.yml
RUN mvn clean package

# Package stage
FROM maven:3.3.9-jdk-8-alpine
WORKDIR /px-doi-ws
COPY --from=build-env /px-doi-ws/target/px-doi-api.jar ./
CMD ["java", "-jar", "px-doi-api.jar"]