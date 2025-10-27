provider "aws" {
  region = "us-east-1"  # Modify region if needed
}

resource "aws_instance" "my_ec2" {
  ami           = "ami-07860a2d7eb515d9a"  # Replace with a valid AMI ID
  instance_type = "t3.micro"
  key_name      = "sumanthlinuxinstancekeypair"  # Replace with an existing AWS key pair
  tags = {
    Name = "terraform-ec2"  # Modify instance name
  }
}

