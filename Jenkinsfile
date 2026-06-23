pipeline {
    agent any

    stages {

        stage('Checkout Code') {
            steps {
                git branch: 'master',
                    url: 'https://github.com/saipatlolla/terraform-ansible-jenkins-project-1.git'
            }
        }

        stage('Verify Ansible') {
            steps {
                sh 'ansible --version'
            }
        }

        stage('Deploy Nginx via Ansible') {
            steps {
                sh '''
                cd ansible
                ansible-playbook -i inventory install_nginx.yml
                '''
            }
        }
    }
}
