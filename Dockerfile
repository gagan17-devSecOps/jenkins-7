# Stage 1: compile the Java program
FROM eclipse-temurin:17-jdk-alpine AS build
WORKDIR /app
COPY HelloWorld.java .
RUN javac HelloWorld.java

# Stage 2: run it on a slim JRE image
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app
COPY --from=build /app/HelloWorld.class .
CMD ["java", "HelloWorld"]
