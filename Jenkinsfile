pipeline {
    agent any

    stages {        
        stage('Build') {
            steps {
                sh "docker rm -f ruby-playground"
                sh "docker build -t ghcr.io/philipsjp26/ruby-playground:${BUILD_NUMBER} ."
                sh "docker run -it ghcr.io/philipsjp26/ruby-playground:${BUILD_NUMBER} -d -p 3000:3000 \
                 --entrypoint /entrypoint/entrypoint.sh \
                 -e RAILS_ENV=${RAILS_ENV} \
                 -e DB_NAME= ${DB_NAME} \
                 -e DB_HOST= ${DB_HOST} \
                 -e DB_USER = ${DB_USER} \
                 -e DB_PASSWORD = ${DB_PASSWORD} \
                 --name ruby-playground \
                 "                
            }
        }
        stage('Deploy image') {
            steps {
                sh 'docker logout'
                sh "docker login ghcr.io -u ${USERNAME} --password-stdin"
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
