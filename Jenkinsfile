pipeline{
    agent any
    tools{
        maven 'mvn'
    }
    environment{
        SCANNER_HOME=tool 'sonar-scanner'
    }
    stages{
        stage('git checkout'){
            steps{
                git branch: 'main', url: 'https://github.com/mukeshr-29/To-do-application-java-k8s-deployment.git'
            }
        }
        stage('code compilation'){
            steps{
                sh 'mvn compile'
            }
        }
        stage('unit testing'){
            steps{
                sh 'mvn test'
            }
        }
        stage('fie system scanning'){
            steps{
                sh 'trivy fs --format table -o trivy-fs-report.html .'
            }
        }
        stage('static code analysis'){
            steps{
                script{
                    withSonarQubeEnv('sonar-server'){
                        sh '''
                            $SCANNER_HOME/bin/sonar-scanner -Dsonar.projectName=To-do-app \
                                -Dsonar.projectKey=To-do-app -Dsonar.java.binaries=target
                        '''
                    }
                }
            }
        }
        stage('build application'){
            steps{
                sh 'mvn package'
            }
        }
        stage('publish artifact to nexus'){
            steps{
                script{
                    withMaven(globalMavenSettingsConfig: '275365f5-062b-4c40-9a16-ffcabbb4c76a', jdk: '', maven: 'mvn', mavenSettingsConfig: '', traceability: true){
                        sh 'mvn deploy'
                    }
                }
            }
        }
        stage('docker image build & tag'){
            steps{
                sh 'docker build -t mukeshr29/to-do_app .'
            }
        }
        stage('scan image using trivy'){
            steps{
                sh 'trivy image --format table -o trivy-img-report.html mukeshr29/to-do_app'
            }
        }
        stage('docker image push to dockerhub'){
            steps{
                script{
                    withDockerRegistry(credentialsId: 'dockerhub', toolName: 'docker'){
                        sh 'docker push mukeshr29/to-do_app'
                    }
                }
            }
        }
    }
}