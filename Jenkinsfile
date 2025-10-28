pipeline {
    agent any

    environment {
        // نعرّف متغيرًا يحتوي على اسم الصورة واسم حساب Docker Hub الخاص بك
        // استبدل 'your-dockerhub-username' باسم المستخدم الخاص بك في Docker Hub
        DOCKER_IMAGE = "bahar771379463/dvna-app" 
    }

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    echo "Building the Docker image: ${DOCKER_IMAGE}"
                    // نستخدم المتغير الذي عرفناه في الأعلى
                    docker.build(DOCKER_IMAGE, '.')
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                // هذا هو الجزء السحري الذي يتصل بـ Vault
                withCredentials([usernamePassword(credentialsId: 'docker-credentials', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    script {
                        echo "Pushing the Docker image to Docker Hub..."
                        // نستخدم بيانات الاعتماد التي سحبناها من Jenkins
                        docker.withRegistry('https://index.docker.io/v1/', 'docker-credentials') {
                            docker.image(DOCKER_IMAGE).push('latest')
                        }
                        echo "Image pushed successfully!"
                    }
                }
            }
        }
    }
}