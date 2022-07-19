pipeline {
    agent any

    stages {
        stage('Build container') {
            steps {
                sh "docker build -t ruby-playground:${BUILD_NUMBER} ."
                sh 'docker rm -f ruby-playground'
            }
        }
    }
}
