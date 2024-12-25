@Library('shared-lib') _
pipeline {
    agent any
    
    environment {
	SCANNER_HOME           = tool 'sonarqube-server'
        dockerHubCredentialsID = 'docker-cred'                          // DockerHub credentials ID.
        imageName              = '3omda1/final-project'            // DockerHub repo/image name.
        openshiftCredentialsID = 'oc-cred'                    // Service account token credentials ID
        openshiftClusterURL    = 'https://api.ocp-training.ivolve-test.com:6443' // OpenShift Cluster URL.
        openshiftProject       = 'ahmedemad'                         // OpenShift project name.
    }

    stages {
        stage('Repo Checkout') {
           steps {
              stage('checkout'){
            steps{
                checkout scmGit(branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/Ahmedemad190/MultiCloudDevOpsProject.git']])
            }
        }


        stage('Run Unit Test') {
            steps {
                script {
                	// Navigate to the directory contains the Application
                    def mvn = tool 'Maven';
                    withSonarQubeEnv(installationName: 'sonarqube-server') {
                        sh "${mvn}/bin/mvn clean verify sonar:sonar -Dsonar.projectKey=devops-working -Dsonar.projectName='devops-working'"                	
                		unitTests()
            		}
        	   }
    	    }
	    }

        stage('Run SonarQube Analysis') {
            steps {
                script {
                    	// Navigate to the directory contains the Application
                    def mvn = tool 'Maven';
                    withSonarQubeEnv(installationName: 'sonarqube-server') {
                        sh "${mvn}/bin/mvn clean verify sonar:sonar -Dsonar.projectKey=devops-working -Dsonar.projectName='devops-working'"                    		sonarQubeAnalysis()
                    	}
                    }
                }
            }

        
        stage('Build & Push Docker Image') {
            steps {
                script {
                    dir('application') {
                        // Navigate to the directory that contains Dockerfile
                        buildAndPushDockerImage(dockerHubCredentialsID, imageName, BUILD_NUMBER)
                    }
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
