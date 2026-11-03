pipeline {
    agent any
    tools { jdk 'JDK17'; maven 'Maven' }
    environment {
        IMAGE = 'DOCKERHUB_USERNAME/educationapp'
        AWS_REGION = 'ap-south-1'
        EKS_CLUSTER = 'education-cluster'
        K8S_NAMESPACE = 'education'
    }
    stages {
        stage('Checkout') { steps { checkout scm } }
        stage('Build and Test') { steps { sh 'mvn -B clean verify' } }
        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('SonarQube') {
                    sh 'mvn -B sonar:sonar -Dsonar.projectKey=educationapp'
                }
            }
        }
        stage('Quality Gate') {
            steps { timeout(time: 5, unit: 'MINUTES') { waitForQualityGate abortPipeline: true } }
        }
        stage('Build Docker Image') { steps { sh 'docker build -t $IMAGE:$BUILD_NUMBER .' } }
        stage('Push Docker Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials',
                    usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh '''
                        echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                        docker push "$IMAGE:$BUILD_NUMBER"
                        docker logout
                    '''
                }
            }
        }
        stage('Deploy to Kubernetes') {
            steps {
                sh '''
                    aws eks update-kubeconfig --region "$AWS_REGION" --name "$EKS_CLUSTER"
                    kubectl set image deployment/educationapp educationapp="$IMAGE:$BUILD_NUMBER" -n "$K8S_NAMESPACE"
                    kubectl rollout status deployment/educationapp -n "$K8S_NAMESPACE" --timeout=180s
                '''
            }
        }
    }
    post {
        success { echo 'Education App deployed successfully.' }
        failure { echo 'Pipeline failed. Review the stage logs.' }
        always { echo 'Pipeline finished.' }
    }
}
