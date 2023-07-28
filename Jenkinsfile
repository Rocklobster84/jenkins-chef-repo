pipeline {
    agent { label "agentfarm" }
    stages {
        stage('Delete the workspace') {
            steps {
                cleanWs()
            }
        }
        stage('Installing Chef Workstation') {
            steps {
                script {
                    def exists = fileExists '/usr/bin/chef-client'
                    if (exists == true) {
                        echo "Skipping Chef Workstation install - already installed"
                    } else {
                        sh 'sudo apt-get install -y wget tree unzip'
                        sh 'wget https://packages.chef.io/files/stable/chef-workstation/23.5.1040/ubuntu/22.04/chef-workstation_23.5.1040-1_amd64.deb'
                        sh 'sudo dpkg -i chef-workstation_23.5.1040-1_amd64.deb'
                        sh 'sudo chef env --chef-license accept'
                }
            }
        }
    }
        stage('Download Apache Cookbook') {
            steps {
                git branch: 'main', credentialsId: 'git-repo', url: 'git@github.com:Rocklobster84/jenkins-chef-repo.git'
            }
        }
        stage('Install Kithen Docker Gem') {
            steps {
                sh 'sudo apt-get install -y make gcc'
                sh 'sudo chef gem install kitchen-docker'
            }
        }
        stage('Run Kitchen Destroy'){
            steps {
                cd cookbooks/apache/
                sh 'sudo kitchen destroy'
            }
        }
        stage('Run Kitchen Create'){
            steps {
                sh 'sudo kitchen create'
            }
        }
        stage('Run Kitchen Converge'){
            steps {
                sh 'sudo kitchen converge'
            }
        }
        stage('Run Kitchen Verify'){
            steps {
                sh 'sudo kitchen verify'
            }
        }
        stage('Kitchen Destroy'){
            steps {
                sh 'sudo kitchen destroy'
            }
        }
    }
}