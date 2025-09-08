pipeline {
    agent any
    // tools { nodejs "Nodejs" }
    environment {
        BUILD_ID = "${env.BUILD_NUMBER}"
        INFRA_JOB = "Terraform-build"
    }
    stages {
        // stage('Install & Build') {
        //     steps {
        //         sh """
        //         npm install
        //         npm run build
        //         """
        //     }
        // }
        stage('Trigger Infra Pipeline') {
            steps {
                build job: "${INFRA_JOB}", parameters: [
                    string(name: 'BUILD_ID', value: "${BUILD_ID}")
                ]
            }
        }
    }
}
