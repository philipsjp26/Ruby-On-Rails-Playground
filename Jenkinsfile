pipeline {
    agent any

    stages {        
        stage('Build') {
            steps {
                sh "docker rm -f ruby-playground"
                sh "docker build -t ghcr.io/philipsjp26/ruby-playground:${BUILD_NUMBER} ."
                sh "docker run -it ghcr.io/philipsjp26/ruby-playground:${BUILD_NUMBER} -d -p 3000:3000 \
                 --entrypoint /entrypoint/entrypoint.sh \
                 -e RAILS_ENV='development' \
                 -e DB_NAME= ${DB_NAME} \
                 -e DB_HOST= ${DB_HOST} \
                 -e DB_USER = ${DB_USER} \
                 -e DB_PASSWORD = ${DB_PASSWORD} \
                 -e CLOUDINARY_CLOUD_NAME = ${CLOUDINARY_CLOUD_NAME} \
                 -e CLOUDINARY_API_KEY = ${CLOUDINARY_API_KEY} \
                 -e CLOUDINARY_API_SECRET = ${CLOUDINARY_API_SECRET} \
                 -e CLOUDINARY_SECURE = ${CLOUDINARY_SECURE} \
                 --name ruby-playground \
                 "                
            }
        }
        // stage('Deploy image') {
        //     steps {
        //         sh 'docker logout'
        //         sh "docker login ghcr.io -u $USERNAME --password-stdin"
        //         sh "docker push ghcr.io/philipsjp26/$imagename:$BUILD_NUMBER"
        //     }
        // }
        // stage('Remove unused image') {
        //     steps {
        //         sh "docker rmi $imagename:$BUILD_NUMBER"
        //         sh "docker rmi $imagename:latest"
        //     }
        // }
    }
}
