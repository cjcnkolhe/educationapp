pipeline {
    agent any

    tools {
        maven 'Maven'
        jdk 'JDK17'
    }

    environment {
        SONAR_TOKEN = credentials('sonar-token')
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'master',
                    url: 'https://github.com/cjcnkolhe/educationapp.git'
            }
        }

        stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('SonarQube Code Analysis') {
            steps {
                sh '''
                    mvn org.sonarsource.scanner.maven:sonar-maven-plugin:5.8.0.7211:sonar \
                    -Dsonar.projectKey=my-project \
                    -Dsonar.projectName=my-project \
                    -Dsonar.host.url=http://13.50.232.101:9000 \
                    -Dsonar.token=$SONAR_TOKEN
                '''
            }
        }
    }
}
