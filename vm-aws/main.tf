provider "aws" {
  region = var.altair_aws_region
}

resource "aws_security_group" "altair_ec2_security_group" {
  name        = "altair-ec2-security-group"
  description = "Allow ssh and http access"

  ingress {
    description = "Allow ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow http"
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

resource "tls_private_key" "altair_ec2_key_pair" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "aws_key_pair" "altair_generated_key" {
  key_name   = "${var.altair_instance_name}-key"
  public_key = tls_private_key.altair_ec2_key_pair.public_key_openssh
}

resource "aws_instance" "altair_ec2_instance" {
  ami           = var.altair_ami_id
  instance_type = var.altair_instance_type
  key_name      = aws_key_pair.altair_generated_key.key_name
  security_groups = [
    aws_security_group.altair_ec2_security_group.name
  ]

  tags = {
    Name = var.altair_instance_name
  }
}

