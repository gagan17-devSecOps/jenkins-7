pipeline {
    agent any

    environment {
        DOCKERHUB_USER = 'gagan535'            
        IMAGE_NAME     = "${DOCKERHUB_USER}/hello-java"
        IMAGE_TAG      = "${BUILD_NUMBER}"
        DOCKER_CREDS   = credentials('my-itiss-dockerhub-key')  // Jenkins credential ID (Username + Access Token)
    }

    stages {

        // ---------- Task 1 (carried over) ----------
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/gagan17-devSecOps/jenkins-7.git'
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

        // ---------- Task 3 (carried over) ----------
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

        // ---------- Task 4 (Fixed) ----------
        stage('Deploy to Kubernetes') {
            steps {
                sh '''
                    # 1. Start Minikube (if not already running) using the Docker driver
                    minikube start --driver=docker || minikube status

                    # 2. Assign the correct userspace/context for kubectl
                    minikube update-context || true

                    # 3. Apply deployment and service manifests
                    kubectl apply -f deployment.yaml
                    kubectl apply -f service.yaml
                '''
            }
        }

        stage('Verify Kubernetes Pod') {
            steps {
                sh '''
                    # Force rollout restart to pull the freshly pushed image tag
                    kubectl rollout restart deployment/java-app-deployment
                    
                    # Wait for deployment completion
                    kubectl rollout status deployment/java-app-deployment
                    
                    # Verify running pods
                    kubectl get pods -l app=java-app
                '''
            }
        }
    }

    post {
        always {
            sh 'docker logout || true'
        }
        success {
            echo "Image pushed and deployed successfully!"
        }
        failure {
            echo 'Pipeline failed - check the stage logs above.'
        }
    }
}
