pipeline {
    agent any

    environment {
        NODEJS_HOME = tool name: 'Nodejs', type: 'NodeJS' // Jenkins NodeJS tool
        PATH = "${env.NODEJS_HOME}/bin:${env.PATH}"
    }

    stages {
        stage('Checkout') {
            steps {
                echo 'Pulling latest code...'
                checkout scm
            }
        }

        stage('Install Dependencies') {
            steps {
                echo 'Installing npm packages...'
                sh 'npm install'
            }
        }

        stage('Build') {
            steps {
                echo 'Building production React app...'
                sh 'npm run build'
            }
        }

        stage('Deploy') {
            steps {
                echo 'Deploying to Nginx...'
                sh '''
                    sudo rm -rf /var/www/html/*
                    sudo cp -r build/* /var/www/html/
                    sudo systemctl restart nginx
                '''
            }
        }
    }

    post {
        success {
            echo '✅ Deployment successful! Visit http://localhost/ to see your app.'
        }
        failure {
            echo '❌ Build or deployment failed.'
        }
    }
}
