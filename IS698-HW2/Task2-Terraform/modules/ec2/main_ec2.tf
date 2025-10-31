
variable "vpc_id" {}
variable "subnet_id" {}
variable "ami_id" {}
variable "instance_type" {}

resource "aws_security_group" "web_sg" {
  name        = "hw2-web-sg"
  description = "Allow HTTP inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  associate_public_ip_address = false

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              echo "<h1>Hello from Sumanth Private EC2 via Terraform</h1>" > /var/www/html/index.html
              systemctl start httpd
              systemctl enable httpd
              EOF

  tags = { Name = "hw2-private-ec2" }
}
