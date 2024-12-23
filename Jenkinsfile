pipeline {
    agent any

    triggers {
        pollSCM('* * * * *')  // Poll SCM every minute
    }

    stages {
        stage('Cleanup') {
                steps {
            sh '''
            # Stop and remove all running and stopped containers
            docker ps -q | xargs -r docker stop
            docker ps -aq | xargs -r docker rm -f

            # Remove the flask image if it exists
            docker images -q flask | xargs -r docker rmi -f

            # Remove directory if it exists
            rm -rf ./flask-catexer-app
            '''
        }
    }
        stage('Build') {
            steps {
                sh 'git clone https://github.com/OmriFialkov/flask-catexer-app.git'
                sh 'cd flask-catexer-app && docker build -t flask .'
            }
        }
        stage('Run') {
            steps {
                sh '''
                docker run --rm -d -p 5000:5000 --name flask flask
                docker ps
                '''
            }
        }
        stage('Test') {
            steps {
                sh 'sleep 5'
                sh '''
                if ! docker logs flask; then
                echo "container logs checking failed!"
                exit 1
                fi
                '''
                sh '''
                if ! curl -f http://localhost:5000; then
                    echo "App is not reachable.."
                    exit 1
                fi
                '''
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying.....'
            }
        }
    }
}
