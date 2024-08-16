pipeline {
    agent any

    stages {
        stage('Pull Code') {
            steps {
                // Clone the repository from GitHub
                git branch: 'devops', url: ''
            }
        }

        stage('Build') {
            steps {
                // Make build.sh executable and run it
                sh 'chmod +x build.sh'
                sh './build.sh'
            }
        }

        stage('Test') {
            steps {
                // Make test.sh executable and run it
                sh 'chmod +x test.sh'
                sh './test.sh'
            }
        }

        stage('Deploy') {
            steps {
                script {
                    echo 'Starting deployment...'

                    // Ensure deploy.sh is executable
                    sh 'chmod +x deploy.sh'
                    
                    // Use withCredentials for SSH key
                    withCredentials([sshUserPrivateKey(credentialsId: 'your-ssh-credentials-id', keyFileVariable: 'SSH_KEY', usernameVariable: 'USER')]) {
                        
                        // Copy deploy.sh to the target server
                        echo 'Running SCP...'
                        sh "scp -i ${SSH_KEY} -o StrictHostKeyChecking=no deploy.sh ${USER}@54.184.219.225:/home/${USER}/deploy/"
                        
                        // Verify that deploy.sh was copied successfully
                        echo 'Checking if deploy.sh was copied...'
                        sh "ssh -i ${SSH_KEY} -o StrictHostKeyChecking=no ${USER}@54.184.219.225 'ls -la /home/${USER}/deploy/'"
                        
                        // Execute the deploy.sh script on the target server
                        echo 'Running SSH...'
                        sh "ssh -i ${SSH_KEY} -o StrictHostKeyChecking=no ${USER}@54.184.219.225 'mkdir -p /home/${USER}/deploy && cd /home/${USER}/deploy && ./deploy.sh'"
                    }
                }
            }
        }
    }

    post {
        always {
            // Clean up the workspace after the pipeline run
            cleanWs()
        }
    }
}
