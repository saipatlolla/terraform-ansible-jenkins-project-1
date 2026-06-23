pipeline {
    agent any

    stages {

        stage('Checkout Code') {
            steps {
                git branch: 'master',
                    url: 'https://github.com/saipatlolla/terraform-ansible-jenkins-project-1.git'
            }
        }

        stage('Terraform apply') {
            steps {
                sh """
                cd terraform
                terraform init
                terraform apply -auto-approve -input=false
                """
            } 
        }

        stage('Get EC2 IP') {
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
            steps {
                sh """
                cd ansible
                echo "[web]" > inventory
                echo "${EC2_IP} ansible_user=ec2-user ansible_ssh_private_key_file=/var/lib/jenkins/.ssh/kubernetes_practice" >> inventory
                """
            }
        }

        stage('Verify Ansible') {
            steps {
                sh 'ansible --version'
            }
        }

        stage('Deploy Nginx via Ansible') {
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
