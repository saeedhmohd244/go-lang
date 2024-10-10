pipeline{
  agent any
  stages{
    stage('git checkout'){
      stage{
        sh ' git clone git changelog: false, credentialsId: 'github', poll: false, url: 'https://github.com/saeedhmohd244/go-lang.git' '
          }
    }
