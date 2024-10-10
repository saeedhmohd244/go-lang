pipeline {
    agent any
    environment {
        AZURE_CREDENTIALS = credentials('azure-credentials-id')  // Azure service principal credentials
        IMAGE_NAME = 'saeedhmohd244/golang:latest'  // or use your preferred tag
        REGISTRY_URL = 'your-registry.azurecr.io'  // Azure Container Registry URL
        AKS_CLUSTER_NAME = 'test'
        RESOURCE_GROUP = 'saeedh'
    }
    stages {
        stage('Git Checkout') {
            steps {
                git changelog: false, credentialsId: 'github', poll: false, url: 'https://github.com/saeedhmohd244/go-lang.git'
            }
        }
        stage('docker build and push ') {
            steps {
                // This step should not normally be used in your script. Consult the inline help for details.
                withDockerRegistry(credentialsId: 'docker', url: 'https://index.docker.io/v1/') {
                    sh '''
                    docker build -t saeedhmohd244/golang .
                    docker tag saeedhmohd244/golang saeedhmohd244/golang:latest
                    docker push saeedhmohd244/golang:latest 
                    '''
                }
            stage('Deploy to AKS') {
            steps {
                script {
                    // Get AKS credentials
                    sh '''
                    az account set --subscription 67eb602f-3151-41ed-b420-0b3b7b92fbbc
                    az aks get-credentials --resource-group saeedh --name test --overwrite-existing
                    '''
                    // Deploy the new image to AKS
                    sh '''
                    kubectl apply -f k8s/deployment.yaml
                    kubectl apply -f k8s/service.yaml
                    kubectl apply -f k8s/ingrss.yaml
                    '''
                }
            }
        }
    }
}

