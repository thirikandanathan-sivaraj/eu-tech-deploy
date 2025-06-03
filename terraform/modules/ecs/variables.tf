variable "project_name" {
  description = "Name prefix for ECS resources"
  type        = string
}

variable "image_url" {
  description = "Docker image URL (e.g., from Docker Hub)"
  type        = string
}

variable "execution_role_arn" {
  description = "IAM role ARN used by ECS tasks to pull images and write logs"
  type        = string
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs for ECS tasks"
  type        = list(string)
}

variable "service_sg_id" {
  description = "Security group ID to attach to the ECS service"
  type        = string
}

variable "target_group_arn" {
  description = "ARN of the target group for ALB"
  type        = string
}

variable "alb_listener" {
  description = "ALB listener used to attach the ECS service (used in depends_on)"
}

