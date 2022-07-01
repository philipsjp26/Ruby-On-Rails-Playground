pipeline {
    agent any

    stages {
        stage('clean') {
            steps{
                sh 'docker image prune -f'
            }
        }
        stage('build image'){
            steps{
                sh 'docker build -t ruby-playground .'
            }
        }
    }
}