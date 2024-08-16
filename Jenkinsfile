pipeline {
    agent any

    stages {
        stage('Clone Repository') {
            steps {
                git 'https://github.com/your-username/shadi-web-app.git'
            }
        }

        stage('Build Application') {
            steps {
                sh './scripts/build.sh'
            }
        }

        stage('Run Tests') {
            steps {
                sh './scripts/test.sh'
            }
        }

        stage('Deploy Application') {
            steps {
                sh './scripts/deploy.sh'
            }
        }
    }
}

