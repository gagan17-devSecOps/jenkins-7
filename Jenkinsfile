pipeline {
    agent any

    environment {
        IMAGE_NAME = 'hello-java'
        IMAGE_TAG  = "${BUILD_NUMBER}"
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

        // ---------- Task 2 ----------
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t ${IMAGE_NAME}:${IMAGE_TAG} .'
                sh 'docker images ${IMAGE_NAME}'
            }
        }

        stage('Run Docker Container') {
            steps {
                // --rm removes the container once it prints and exits
                sh 'docker run --rm ${IMAGE_NAME}:${IMAGE_TAG}'
            }
        }
    }

    post {
        success {
            echo 'Docker image built and container ran successfully.'
        }
        failure {
            echo 'Pipeline failed - check the stage logs above.'
        }
    }
}
