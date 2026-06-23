provider "aws" {
  region = "eu-north-1"
}

resource "aws_instance" "app_server" {
  ami           = "ami-07ba4be829b9bf20a"
  instance_type = "t3.micro"
  key_name = "kubernetes_practice"

  tags = {
    Name = "DevOps-App-Server"
  }
}
