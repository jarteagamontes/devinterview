output "altair_instance_public_ip" {
  value       = aws_instance.altair_ec2_instance.public_ip
  description = "Public IP of the EC2 instance"
}

output "altair_instance_id" {
  value       = aws_instance.altair_ec2_instance.id
  description = "ID of the EC2 instance"
}

