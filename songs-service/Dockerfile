FROM gradle:8.10.2-jdk21 AS builder
WORKDIR /gradle/build

COPY ../gradlew ./
COPY ../gradle ./gradle
COPY ../build.gradle ./
COPY ../settings.gradle ./

COPY ../songs-service/build.gradle songs-service/

COPY ../songs-service/src/ songs-service/src/

RUN ./gradlew :songs-service:clean :songs-service:build

# Smaller OS footprint using JRE
FROM openjdk:21
WORKDIR /app

COPY --from=builder /gradle/build/songs-service/build/libs/*.jar /app/app.jar

CMD ["java", "-jar", "app.jar"]