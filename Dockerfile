# Stage 1: Compile the Java source code
FROM eclipse-temurin:17-jdk-slim AS builder
WORKDIR /jenkins/jenkins-7
COPY Main.java .
RUN javac Main.java

# Stage 2: Run the application
FROM eclipse-temurin:17-jre-slim
WORKDIR /jenkins/jenkins-7
COPY --from=builder /jenkins/jenkins-7/Main.class .
CMD ["java", "Main"]
