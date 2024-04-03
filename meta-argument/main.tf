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


# resource "aws_iam_group" "gp1" {
#   name = "manager24"
#   lifecycle {
#     prevent_destroy = false
#   }
# }

# resource "aws_iam_user" "usr1" {
#   name = "banga2425"
#   depends_on = [ aws_iam_group.gp1 ]
# }

resource "aws_instance" "server1" {
  ami           = "ami-033a1ebf088e56e81"
  key_name      = "wordpress-key"
  instance_type = "t3.small"

  lifecycle {
    create_before_destroy = true
  }

}