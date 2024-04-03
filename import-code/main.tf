# __generated__ by Terraform
# Please review these resources and move them into your main configuration files.

# __generated__ by Terraform
resource "aws_instance" "web" {
  ami                                  = "ami-033a1ebf088e56e81"
  associate_public_ip_address          = true
  availability_zone                    = "us-east-1d"
  instance_type                        = "t2.micro"
  key_name                             = "wordpress-key"
  monitoring                           = false
  security_groups                      = ["launch-wizard-3"]
  subnet_id                            = "subnet-092b66994807bad09"
  tags = {
    Name = "webserver"
  }
}
