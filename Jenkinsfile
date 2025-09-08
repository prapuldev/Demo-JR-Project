pipeline {
    agent any
    // tools { nodejs "Nodejs" }
    
    environment {
        BUILD_ID = "${env.BUILD_NUMBER}"        // React job build number
        INFRA_JOB = "Terraform-build"          // Downstream Terraform job
    }
    
    stages {
        // Optional React build stage
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
                script {
                    // Trigger Terraform-build and pass BUILD_ID as a parameter
                    build job: "${INFRA_JOB}", 
                          parameters: [
                              string(name: 'BUILD_ID', value: "${BUILD_ID}")
                          ], 
                          wait: true,       // Wait for the downstream job to complete
                          propagate: true   // Fail this job if the downstream job fails
                }
            }
        }
    }
}
