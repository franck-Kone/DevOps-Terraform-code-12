terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.61.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "demo1" {
  ami           = "ami-033a1ebf088e56e81"
  instance_type = "t2.micro"
  key_name      = "week12key"
}

# Generate a secure key using a rsa algorithm
resource "tls_private_key" "ec2_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}
# creating the keypair in aws
resource "aws_key_pair" "ec2_key" {
  key_name   = "week12key"
  public_key = tls_private_key.ec2_key.public_key_openssh
}
# Save the .pem file locally for remote connection
resource "local_file" "ssh_key" {
  filename = "${aws_key_pair.ec2_key.key_name}.pem"
  content  = tls_private_key.ec2_key.private_key_pem
}

resource "null_resource" "n1" {
  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file(local_file.ssh_key.filename)
    host        = aws_instance.demo1.public_ip
  }

  provisioner "local-exec" {
    command = "echo Hello World"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo useradd banga",
      "mkdir terraform"
    ]
  }

  provisioner "file" {
    source      = local_file.ssh_key.filename #path of a file in our local machine
    destination = "/tmp/key.pem"
  }

  depends_on = [aws_instance.demo1, local_file.ssh_key]
}
