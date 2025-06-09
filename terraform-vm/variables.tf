variable "aws_region" {
  description = "AWS region to deploy Zabbix EC2 instance"
  default     = "us-east-1"
}

variable "key_name" {
  description = "The EC2 key pair name to use for SSH"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC to launch the instance in"
  type        = string
}

variable "public_subnet_id" {
  description = "The ID of the public subnet to launch the instance in"
  type        = string
}
