pipeline {
    agent any
    stages {
        stage('Git Checkout') {
            steps {
                git changelog: false, credentialsId: 'github', poll: false, url: 'https://github.com/saeedhmohd244/go-lang.git'
            }
        }
        stage('docker build ') {
            steps {
                // This step should not normally be used in your script. Consult the inline help for details.
                withDockerRegistry(credentialsId: 'docker', toolName: 'docker', url: 'https://index.docker.io/v1/') {
                    sh '''
                    docker build -t saeedhmohd244/golang .
                    docker tag saeedhmohd244/golang saeedhmohd244/golang:latest
                    docker push saeedhmohd244/golang:latest 
                    '''
                }
            }
        }
    }
}

