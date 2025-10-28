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
                // نستخدم Vault لسحب كلمة المرور. هذا الجزء حساس.
                // سنستخدم اسم ID مختلف لبيانات الاعتماد لتجنب أي التباس
                withCredentials([string(credentialsId: 'vault-docker-tokin', variable: 'DOCKAR_HUB_PASSWORD')]) {
                    echo "Logging in to Docker Hub..."
                    // أمر تسجيل الدخول الصريح باستخدام كلمة المرور من Vault
                    sh "echo ${DOCKAR_HUB_PASSWORD} | docker login -u ${DOCKER_USERNAME} --password-stdin"
                        
                    echo "Pushing the Docker image..."
                    // أمر الدفع الصريح
                    sh "docker push ${DOCKER_USERNAME}/${APP_NAME}:latest"
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