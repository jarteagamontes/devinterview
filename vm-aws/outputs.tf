output "altair_instance_public_ip" {
  value       = aws_instance.altair_ec2_instance.public_ip
  description = "Public IP of the EC2 instance"
}

output "altair_private_key" {
  value       = tls_private_key.altair_ec2_key_pair.private_key_pem
  description = "Private key for the EC2 instance"
  sensitive   = true
}

