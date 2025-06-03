variable "project_name" {
  description = "Prefix for resource names"
  type        = string
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs"
  type        = list(string)
}

variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "alb_sg_id" {
  description = "Security group for the ALB"
  type        = string
}

