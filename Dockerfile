FROM openjdk:11.0.11-jre-slim
WORKDIR /jenkins/jenkins-7
COPY app.class .
CMD ["java", "app.java"]
