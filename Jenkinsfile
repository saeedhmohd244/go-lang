pipeline {
    agent any
    stages {
        stage('Git Checkout') {
            steps {
                git(
                    changelog: false,
                    credentialsId: 'github',  // Ensure 'github' is the correct credentials ID in your Jenkins
                    poll: false,
                    url: 'https://github.com/saeedhmohd244/go-lang.git'
                )
            }
        }
    }
}
