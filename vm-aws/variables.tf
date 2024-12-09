variable "altair_aws_region" {
  description = "aws region"
  type        = string
  default     = "us-east-1"
}

variable "altair_ami_id" {
  description = "Type machinme"
  type        = string
  default     = "ami-0453ec754f44f9a4a"
}

variable "altair_instance_type" {
  description = "ec2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "altair_instance_name" {
  description = "Name of the ec2"
  type        = string
}
