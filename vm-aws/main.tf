provider "aws" {
  region = var.altair_aws_region
}

resource "aws_security_group" "altair_ec2_security_group" {
  name        = "altair-ec2-security-group"
  description = "Allow SSH and HTTP access"

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTP"
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

resource "aws_instance" "altair_ec2_instance" {
  ami           = var.altair_ami_id
  instance_type = var.altair_instance_type
  key_name      = null # No utilizaremos una clave pública
  security_groups = [
    aws_security_group.altair_ec2_security_group.name
  ]

  tags = {
    Name = var.altair_instance_name
  }

  user_data = <<-EOF
              #!/bin/bash
              echo 'ec2-user:${var.altair_instance_password}' | chpasswd
              sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
              systemctl restart sshd
            EOF
}

output "altair_instance_public_ip" {
  value       = aws_instance.altair_ec2_instance.public_ip
  description = "Public IP of the EC2 instance"
}

