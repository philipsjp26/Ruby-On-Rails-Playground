pipeline {
    agent any
    stages {
        environment {
            USERNAME = credentials('username')
            PASSWORD = credentials('password')
        }
        stage('Build') {
            steps {
                sh 'docker rm -f ruby-playground'
                sh "docker build -t ghcr.io/philipsjp26/ruby-playground:${BUILD_NUMBER} ."
                sh "docker run -d ghcr.io/philipsjp26/ruby-playground:${BUILD_NUMBER} -p 3000:3000 \
                 -e RAILS_ENV=${RAILS_ENV} \
                 -e DB_NAME=${DB_NAME} \
                 -e DB_HOST=${DB_HOST} \
                 -e DB_USER=${DB_USER} \
                 -e DB_PASSWORD=${DB_PASSWORD} \
                 --name ruby-playground"
            }
        }
        stage('Deploy image') {
            steps {
                sh 'docker logout'
                sh "echo ${PASSWORD} | docker login ghcr.io -u ${USERNAME} --password-stdin"
                sh "docker push ghcr.io/philipsjp26/ruby-playground:${BUILD_NUMBER}"
            }
        }
        stage('Remove unused image') {
            steps {
                sh "docker rmi ruby-playground:${BUILD_NUMBER}"
            }
        }
    }
}
