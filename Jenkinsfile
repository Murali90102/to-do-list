pipeline {
    agent { label 'slave' }	
    environment {	
		DOCKERHUB_CREDENTIALS=credentials('dockerlogin')
        IMAGE_NAME = "todolist"
        TAG = "${BUILD_ID}"
        REPO = "murali90102"
	} 
    stages {
        stage('SCM Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Murali90102/to-do-list.git'
            }
		}
        stage("Docker build"){
            steps {
				sh 'docker version'
				sh "docker build -t ${REPO}/${IMAGE_NAME}:${TAG} ."
				sh 'docker ps'
            }
        }
        stage('DockerHub_login') {

			steps {
				sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
			}
		}
        stage('Push2DockerHub') {

			steps {
				sh "docker push ${REPO}/${IMAGE_NAME}:${TAG}"
			}
		}
		stage('Deploy to Kubernetes Cluster') {
            steps {
                sh "sed -i \"s#murali90102/todolist:16#${REPO}/${IMAGE_NAME}:${TAG}#1\" deployment.yaml"
		        script {
		                 sshPublisher(publishers: [sshPublisherDesc(configName: 'kubernetes', transfers: [sshTransfer(cleanRemote: false, excludes: '', execCommand: 'kubectl apply -f deployment.yaml', execTimeout: 120000, flatten: false, makeEmptyDirs: false, noDefaultExcludes: false, patternSeparator: '[, ]+', remoteDirectory: '.', remoteDirectorySDF: false, removePrefix: '', sourceFiles: 'deployment.yaml')], usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: false)])
		                }
                  }
	    }
    }
    post {
        success{emailext body: '$JOB_NAME is success', subject: '$JOB_NAME is success', to: 'murali.appari@outlook.com'}
        failure{emailext body: '$JOB_NAME is failure', subject: '$JOB_NAME is failure', to: 'murali.appari@outlook.com'}
    }
}
