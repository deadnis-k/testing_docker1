pipeline {
    agent any

    stages {
        stage('clean code') {
            steps {
                echo 'Cleaning up any existing repository folder...'
                sh 'rm -rf testing_docker1'
            }
        }
        stage('clone code') {
            steps {
                echo 'Cloning the repository...'
                sh 'git clone https://github.com/deadnis-k/testing_docker1.git'
            }
        }
        stage('Stop and Remove Docker Containers') {
            steps {
                script {
                    echo 'Stopping and removing all Docker containers...'
                    // Stop all running containers
                    sh '''
                    docker ps -q | xargs -r docker stop
                    '''
                    // Remove all containers (including stopped ones)
                    sh '''
                    docker ps -aq | xargs -r docker rm
                    '''
                }
            }
        }
        stage('Remove Docker Images') {
            steps {
                script {
                    echo 'Removing all Docker images...'
                    // Remove all Docker images
                    sh '''
                    docker images -q | xargs -r docker rmi -f
                    '''
                }
            }
        }
        stage('docker build') {
            steps {
                echo 'Building Docker image...'
                sh 'docker build -t test:0.0.1 testing_docker1'
            }
        }
        stage('docker run') {
            steps {
                echo 'Running Docker container...'
                sh 'docker run -d -p 5000:5000 test:0.0.1'
            }
        }
        stage('is the site online') {
            steps {
                echo 'Checking connectivity to the site...'
                sh 'ping -c 4 localhost'
            }
        }
    }

    post {
        always {
            // Clean up and ensure the system is in a stable state
            echo 'Cleaning up unused Docker resources...'
            sh 'docker system prune -f'
        }
    }
}
