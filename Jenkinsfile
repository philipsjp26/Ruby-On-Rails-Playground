pipeline {
    agent any
    environment {
        GITHUB_TOKEN=credentials('github-token')
    }
    stages {
        stage('clean') {
            steps{
                sh 'docker image rm ${IMAGE_NAME}'
            }
        }
        stage('build image'){
            steps{
                sh 'docker build -t ${IMAGE_NAME} .'
            }
        }
        stage('login to GHCR'){
            steps{
                sh 'echo $GITHUB_TOKEN | docker login ghcr.io -u $GITHUB_TOKEN_USR --password-stdin'
            }
        }
    }
}