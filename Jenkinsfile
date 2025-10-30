pipeline {
    agent any

    environment {
        // استبدل 'your-dockerhub-username' باسم المستخدم الخاص بك في Docker Hub
        DOCKER_USERNAME = "bahar771379463"
        APP_NAME = "dvna-app"
    }

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    echo "Building the Docker image..."
                    
                    sh "docker build -t ${DOCKER_USERNAME}/${APP_NAME}:latest ."
                }
            }
        }

      stage('Login & Push to Docker Hub') {
    steps {
        
        withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
            
            // تسجيل الدخول باستخدام المتغيرات
            sh "echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin"
            
           
            sh "docker push bahar771379463/dvna-app:latest"
        }
    }
}
    }
        
    post {
        always {
            // خطوة تنظيف مهمة جدًا
            echo "Logging out from Docker Hub..."
            sh "docker logout"
        }
    }
}