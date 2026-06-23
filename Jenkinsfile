pipeline {
    agent any

    stages {

        stage('Verify Ansible') {
            steps {
                sh '''
                cd ansible
                ansible --version
                '''
            }
        }

        stage('Deploy Nginx') {
            steps {
                sh '''
                cd ansible
                ansible-playbook -i inventory playbook.yml
                '''
            }
        }
    }
}
