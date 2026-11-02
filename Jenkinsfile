pipeline {
    agent any

    environment {
        DOCKERHUB_USER = 'gagan535'            // <-- change this
        IMAGE_NAME     = "${DOCKERHUB_USER}/hello-java"
        IMAGE_TAG      = "${BUILD_NUMBER}"
        DOCKER_CREDS   = credentials('my-itiss-dockerhub-key')  // Jenkins credential ID (Username + Access Token)
    }

    stages {

        // ---------- Task 1 (carried over) ----------
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/gagan17-devSecOps/jenkins-7.git' // <-- change this
            }
        }

        stage('Compile') {
            steps {
                sh 'javac HelloWorld.java'
            }
        }

        stage('Run Application') {
            steps {
                sh 'java HelloWorld'
            }
        }

        // ---------- Task 2 (carried over) ----------
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t ${IMAGE_NAME}:${IMAGE_TAG} .'
            }
        }

        stage('Run Docker Container') {
            steps {
                sh 'docker run --rm ${IMAGE_NAME}:${IMAGE_TAG}'
            }
        }

        // ---------- Task 3 ----------
        stage('Tag Image') {
            steps {
                sh 'docker tag ${IMAGE_NAME}:${IMAGE_TAG} ${IMAGE_NAME}:latest'
                sh 'docker images ${IMAGE_NAME}'
            }
        }

        stage('Push to DockerHub') {
            steps {
                sh '''
                    echo "$DOCKER_CREDS_PSW" | docker login -u "$DOCKER_CREDS_USR" --password-stdin
                    docker push ${IMAGE_NAME}:${IMAGE_TAG}
                    docker push ${IMAGE_NAME}:latest
                '''
            }
        }
    }

    post {
        always {
            sh 'docker logout || true'
        }
        success {
            echo "Image pushed: https://hub.docker.com/repository/docker/gagan535/${IMAGE_NAME}/tags"
        }
        failure {
            echo 'Pipeline failed - check the stage logs above.'
        }
    }
}

