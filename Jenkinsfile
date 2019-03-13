pipeline {
  agent any
  stages {
    stage('Env') {
      steps {
        sh 'env'
      }
    }
  }
  environment {
    FOO = 'BAR'
    Ipsum = 'Lorem'
  }
}