@Library('shared-lib') _
pipeline {
    agent any
    tools {
        gradle 'gradle'
        
    }
    environment {
        SCANNER_HOME           = tool 'gradle'
        dockerHubCredentialsID = 'final-2'                          // DockerHub credentials ID.
        imageName              = '3omda2/final-project'                  // DockerHub repo/image name.
        openshiftCredentialsID = 'oc-cred'                               // Service account token credentials ID
        openshiftClusterURL    = 'https://api.ocp-training.ivolve-test.com:6443' // OpenShift Cluster URL.
        openshiftProject       = 'ahmedemad'                             // OpenShift project name.
    }

    stages {
        stage('Repo Checkout') {
            steps {
                script {
                    gitcheckout()
                }
            }
        }

        stage('Run Unit Test') {
            steps {
                script {
                    // Navigate to the directory containing the Application
                    unitTests()
                }
            }
        }

        stage('Run SonarQube Analysis') {
            steps {
                script {
                    // Navigate to the directory containing the Application
                    sonarQubeAnalysis()
                }
            }
        }

        stage('Build & Push Docker Image') {
            steps {
                script {
                    
                        // Navigate to the directory that contains Dockerfile
                        buildandpushDockerImage(dockerHubCredentialsID, imageName, BUILD_NUMBER)
                    
                }
            }
        }

        stage('Deploy on OpenShift Cluster') {
            steps {
                script {
                    dir('openshift') {
                        deployToOpenShift(openshiftCredentialsID, openshiftClusterURL, openshiftProject, imageName, BUILD_NUMBER)
                    }
                }
            }
        }
    }

    post {
        always {
            echo "Pipeline completed."
            cleanWs() // Clean workspace after the build is finished
        }
        success {
            echo "${JOB_NAME}-${BUILD_NUMBER} pipeline succeeded"
        }
        failure {
            echo "${JOB_NAME}-${BUILD_NUMBER} pipeline failed"
        }
    }
}
