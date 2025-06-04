variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "CIDRs block for the public subnet"
  type = list(string)
}


variable "private_subnet_cidrs" {
  description = "CIDRs block for the private subnet"
  type = list(string)
}

variable "azs" {
  description = "Availability zone"
  type = list(string)
}

variable "project_name" {
  description = "Name prefix for resources"
  type        = string
}

