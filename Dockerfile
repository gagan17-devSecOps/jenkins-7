FROM openjdk:11.0.11-jre-slim
COPY app.class .
CMD ["java", "app.java"]
