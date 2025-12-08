output "vpc_id" {
  value       = aws_vpc.main.id
  description = "ID of the main VPC"
}

output "public_subnet_ids" {
  value       = [for s in aws_subnet.public : s.id]
  description = "IDs of public subnets"
}

output "private_subnet_ids" {
  value       = [for s in aws_subnet.private : s.id]
  description = "IDs of private subnets"
}

output "alb_sg_id" {
  value       = aws_security_group.alb_sg.id
  description = "ALB security group ID"
}

output "web_sg_id" {
  value       = aws_security_group.web_sg.id
  description = "Web server security group ID"
}

output "rds_sg_id" {
  value       = aws_security_group.rds_sg.id
  description = "RDS security group ID"
}
