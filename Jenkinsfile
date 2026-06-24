pipeline {
    agent any

    stages {

        stage('Checkout Code') {
            agent { label 'terraform-agent' }
            steps {
                git branch: 'master',
                    url: 'https://github.com/saipatlolla/terraform-ansible-jenkins-project-1.git'
            }
        }

        stage('Terraform apply') {
            agent { label 'terraform-agent' }
            steps {
                sh """
                cd terraform
                terraform init
                terraform apply -auto-approve -input=false
                """
            } 
        }

        stage('Get EC2 IP') {
            agent { label 'terraform-agent' }
            steps {
                 script {
                     env.EC2_IP = sh(
                         script: "cd terraform && terraform output -raw public_ip",
                         returnStdout: true
                     ).trim()

                     echo "EC2 IP is: ${EC2_IP}"
                 } 
            }
        }

        stage('Create Inventory') {
            agent { label 'ansible-agent' }
            steps {
                    sh """
                    cd ansible
                    echo "[web]" > inventory
                    echo "${EC2_IP} ansible_user=ec2-user ansible_ssh_private_key_file=/var/lib/jenkins/.ssh/kubernetes_practice" >> inventory
                    cat inventory
                    """
            }
        }

        stage('Verify Ansible') {
            agent { label 'ansible-agent' }
            steps {
                sh 'ansible --version'
            }
        }

        stage('Deploy Nginx via Ansible') {
            agent { label 'ansible-agent' }
            steps {
                sh """
                cd ansible
                export ANSIBLE_HOST_KEY_CHECKING=False
                ansible-playbook -i inventory install_nginx.yml
                """
            }
        }
    }
}
