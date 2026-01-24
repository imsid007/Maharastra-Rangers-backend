output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.app.id
}

output "private_ip" {
  description = "Private IP of the EC2 instance"
  value       = aws_instance.app.private_ip
}

output "public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.app.public_ip
}

output "security_group_id" {
  description = "ID of the EC2 security group"
  value       = aws_security_group.ec2.id
}
