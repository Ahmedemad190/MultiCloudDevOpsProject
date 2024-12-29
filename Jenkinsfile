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
        cred = credentials('aws-key')
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
                    unitTests()
                }
            }
        }

        stage('Run SonarQube Analysis') {
            steps {
                script {
                    sonarQubeAnalysis()
                }
            }
        }

        stage('Build & Push Docker Image') {
            steps {
                script {
                    
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
            cleanWs() 
        }
        success {
            echo "pipeline succeeded"
        }
        failure {
            echo "pipeline failed"
        }
    }
}
