# Stage 1: Build the application
FROM gradle:8.5-jdk17-alpine AS build
WORKDIR /app
COPY . .
RUN gradle clean build -x test

# Stage 2: Create the final image
FROM openjdk:17-jdk-slim
WORKDIR /app
# Copy the built JAR file from the build stage
COPY --from=build /app/build/libs/*.jar app.jar
# Expose the port the application runs on
EXPOSE 8080
# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
