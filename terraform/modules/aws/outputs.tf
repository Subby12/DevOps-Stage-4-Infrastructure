output "public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.app_instance.public_ip
}

output "public_dns" {
  description = "Public DNS of the EC2 instance"
  value       = aws_instance.app_instance.public_dns
}

output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.app_instance.id
}