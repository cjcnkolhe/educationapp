
pipeline {
    agent any

    tools {
        maven 'Maven'
        jdk 'JDK17'
    }

    environment {
        DOCKER_IMAGE = 'nanducjc123/educationapprepo'
        SONAR_HOST = 'http://13.50.232.101:9000'
        CONTAINER_NAME = 'educationapp'
        APP_PORT = '8080'
    }

    stages {

        stage('Git Checkout') {
            steps {
                git branch: 'master',
                    url: 'https://github.com/cjcnkolhe/educationapp.git'
            }
        }

        stage('Maven Build') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                withCredentials([
                    string(
                        credentialsId: 'sonar-token',
                        variable: 'SONAR_TOKEN'
                    )
                ]) {
                    sh '''
                        mvn org.sonarsource.scanner.maven:sonar-maven-plugin:5.8.0.7211:sonar \
                        -Dsonar.projectKey=my-project \
                        -Dsonar.projectName=my-project \
                        -Dsonar.host.url=$SONAR_HOST \
                        -Dsonar.token=$SONAR_TOKEN
                    '''
                }
            }
        }

        stage('Docker Build') {
            steps {
                sh '''
                    docker build -t $DOCKER_IMAGE:latest .
                '''
            }
        }

        stage('Docker Login & Push') {
            steps {
                withCredentials([
                    usernamePassword(
                        credentialsId: 'dockerhub-credentials',
                        usernameVariable: 'DOCKER_USER',
                        passwordVariable: 'DOCKER_PASS'
                    )
                ]) {
                    sh '''
                        set +x

                        echo "$DOCKER_PASS" | docker login \
                        -u "$DOCKER_USER" --password-stdin

                        docker push $DOCKER_IMAGE:latest

                        docker logout
                    '''
                }
            }
        }

        stage('Docker Pull') {
            steps {
                sh '''
                    docker pull $DOCKER_IMAGE:latest
                '''
            }
        }

       stage('Docker Run / Deploy') {
    steps {
        sh '''
            docker rm -f educationapp || true

            docker run -d \
            --name educationapp \
            --restart unless-stopped \
            -p 8081:8080 \
            nanducjc123/educationapprepo:latest

            docker ps
        '''
    }
}
    }

    post {
        success {
            echo 'Pipeline completed successfully!'
            echo 'Docker application deployed successfully!'
        }

        failure {
            echo 'Pipeline failed!'
        }

        always {
            echo 'Jenkins pipeline execution finished.'
        }
    }
}
