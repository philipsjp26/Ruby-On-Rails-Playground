pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                sh 'docker rm -f ruby-playground'
                sh "docker build -t ghcr.io/philipsjp26/ruby-playground:${BUILD_NUMBER} ."
                sh "docker run -d -t -i ghcr.io/philipsjp26/ruby-playground:${BUILD_NUMBER} -p 3000:3000 \
                 -e RAILS_ENV='${RAILS_ENV}' \
                 -e DB_NAME='${DB_NAME}' \
                 -e DB_HOST='${DB_HOST}' \
                 -e DB_USER='${DB_USER}' \
                 -e DB_PASSWORD='${DB_PASSWORD}' \
                 --name ruby-playground"
            }
        }
        stage('Deploy image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'd4f727d4-36ba-4f6f-938e-be9fe3db95c9', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                    sh 'docker logout'
                    sh "echo ${PASSWORD} | docker login ghcr.io -u ${USERNAME} --password-stdin"
                    sh "docker push ghcr.io/philipsjp26/ruby-playground:${BUILD_NUMBER}"
                }                
            }
        }
        stage('Remove unused image') {
            steps {
                sh "docker image prune --all --filter until=23m"
            }
        }
    }
}
