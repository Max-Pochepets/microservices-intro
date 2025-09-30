FROM gradle:8.10.2-jdk21 AS builder
WORKDIR /gradle/build

COPY ../gradlew ./
COPY ../gradle ./gradle
COPY ../build.gradle ./
COPY ../settings.gradle ./

COPY ../eureka/build.gradle eureka/

COPY ../eureka/src/ eureka/src/

RUN ./gradlew :eureka:clean :eureka:build

# Smaller OS footprint using JRE
FROM openjdk:21
WORKDIR /app

# Copy only the Jar from the current dir
COPY --from=builder /gradle/build/eureka/build/libs/*.jar /app/app.jar

# Run the Jar = Final image only containes
CMD ["java", "-jar", "app.jar"]
