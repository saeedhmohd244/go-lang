pipeline {
    agent any
    
    environment {
        AZURE_CREDENTIALS = credentials('azure-credentials-id') // Azure service principal credentials
        IMAGE_NAME = 'saeedhmohd244/golang:latest' // or use your preferred tag
        REGISTRY_URL = 'your-registry.azurecr.io' // Azure Container Registry URL
        AKS_CLUSTER_NAME = 'test'
        RESOURCE_GROUP = 'saeedh'
    }

    stages {
        stage('Git Checkout') {
            steps {
                git changelog: false, credentialsId: 'github', poll: false, url: 'https://github.com/saeedhmohd244/go-lang.git'
            }
        }

        stage('Docker Build and Push') {
            steps {
                script {
                    withDockerRegistry(credentialsId: 'docker', url: 'https://index.docker.io/v1/') {
                        sh '''
                        docker build -t saeedhmohd244/golang .
                        docker push saeedhmohd244/golang:latest 
                        '''
                    }
                }
            }
        }

        stage('Deploy to AKS') {
            steps {
                script {
                    // Get AKS credentials
                    sh '''
                    az account set --subscription 67eb602f-3151-41ed-b420-0b3b7b92fbbc
                    az aks get-credentials --resource-group ${RESOURCE_GROUP} --name ${AKS_CLUSTER_NAME} --overwrite-existing
                    '''

                    // Deploy the new image to AKS
                    sh '''
                    kubectl apply -f k8s/deployment.yaml
                    kubectl apply -f k8s/service.yaml
                    kubectl apply -f k8s/ingress.yaml
                    '''
                }
            }
        }
    }

    post {
        always {
            script {
                // Clean up resources or log out from Azure if necessary
                sh "az logout"
            }
        }
    }
}


