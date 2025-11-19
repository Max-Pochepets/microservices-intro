FROM gradle:8.10.2-jdk21 AS builder
WORKDIR /gradle/build

COPY ../gradlew ./
COPY ../gradle ./gradle
COPY ../build.gradle ./
COPY ../settings.gradle ./

COPY ../resources-service/build.gradle resources-service/

COPY ../resources-service/src/ resources-service/src/

RUN ./gradlew :resources-service:clean :resources-service:build

# Smaller OS footprint using JRE
FROM openjdk:21-rc-slim
WORKDIR /app

# Copy only the Jar from the current dir
COPY --from=builder /gradle/build/resources-service/build/libs/*.jar /app/app.jar

CMD ["java", "-jar", "app.jar"]

