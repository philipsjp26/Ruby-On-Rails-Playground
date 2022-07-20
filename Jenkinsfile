pipeline {
    agent any

    stages {
        stage('Build') {
            when {
                anyOf {
                    branch 'development'
                }
            }
            steps {
                sh "docker build -t ghcr.io/philipsjp26/$imagename:$BUILD_NUMBER ."
                sh "docker run ghcr.io/philipsjp26/$imagename:$BUILD_NUMBER"
            }
        }
        stage('Deploy image') {
            steps {
                sh 'docker logout'
                sh "docker login ghcr.io -u $USERNAME --password-stdin"
                sh "docker push ghcr.io/philipsjp26/$imagename:$BUILD_NUMBER"
            }
        }
        stage('Remove unused image') {
            steps {
                sh "docker rmi $imagename:$BUILD_NUMBER"
                sh "docker rmi $imagename:latest"
            }
        }
    }
}
