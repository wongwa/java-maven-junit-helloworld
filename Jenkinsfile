pipeline {
    agent any

  environment {
    imagename = "uclabruin87/javaapp:test"
    registryCredential = 'uclabruin87-uclabruin87'
    dockerImage = ''
  }
  
  tools {
        // Install the Maven version configured as "M3" and add it to the path.
        maven "localMaven"
    }

    stages {

        stage('Build') {
            steps {
                // Get some code from a GitHub repository
                git 'https://github.com/wongwa/java-maven-junit-helloworld.git/'

                // Run Maven on a Unix agent.
                sh "mvn -Dmaven.test.failure.ignore=true clean package"

                // To run Maven on a Windows agent, use
                // bat "mvn -Dmaven.test.failure.ignore=true clean package"
                script
                {
                    dockerImage = docker.build imagename
                }
            }

            post {
                // If Maven was able to run the tests, even if some of the test
                // failed, record the test results and archive the jar file.
                success {
                    junit '**/target/surefire-reports/TEST-*.xml'
                    archiveArtifacts 'target/*.jar'
                }
            }
        }
        stage('Deploy')
        {
          steps{
                sh '/var/lib/jenkins/password.sh | docker login -u uclabruin87 --password-stdin '
                sh 'docker push uclabruin87/javaapp:test'
                sh 'docker rmi uclabruin87/javaapp:test'
            }
        }
        stage('Pull-Run')
        {
            steps
            {
                sh 'docker pull uclabruin87/javaapp:test'
                sh 'docker run -d --rm  uclabruin87/javaapp:test'
            }
        }
        stage('Clean-up')
        {
            steps
            {
                //sh 'docker rm $(docker ps -a -q)'
                sh 'docker system prune -f'
            }
        }
    }
}
