FROM openjdk:11.0.11-jre-slim
WORKDIR /jenkins/jenkins-7
COPY --from=builder /jenkins/jenkins-7/Main.class .
CMD ["java", "Main"]
