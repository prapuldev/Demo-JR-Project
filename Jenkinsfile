pipeline {
    agent any

    environment {
       // NODEJS_HOME = tool name: 'Nodejs', type: 'NodeJS'
        //PATH = "${env.NODEJS_HOME}/bin:${env.PATH}"
        BRANCH_NAME = "feature-branch"
    }

    stages {
        stage('Checkout') {
            steps {
                echo 'Checking out branch...'
                checkout scm
            }
        }

        stage('Commit & Push Changes') {
            steps {
                echo "Committing local changes and pushing to ${BRANCH_NAME}..."
                sh '''
                    git config user.email "jenkins@local"
                    git config user.name "Jenkins CI"

                    # Add & commit only if there are changes
                    if [ -n "$(git status --porcelain)" ]; then
                        git add .
                        git commit -m "Auto-commit: Jenkins pipeline changes"
                        git push origin ${BRANCH_NAME}
                    else
                        echo "No changes to commit."
                    fi
                '''
            }
        }

        stage('Install Dependencies') {
            steps {
                echo 'Installing npm dependencies...'
                sh 'npm install'
            }
        }

        stage('Build') {
            steps {
                echo 'Building React app...'
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
            echo "✅ Build & Deploy successful. App updated at http://localhost/"
        }
        failure {
            echo "❌ Pipeline failed."
        }
    }
}
