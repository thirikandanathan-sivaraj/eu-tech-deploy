provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source              = "./modules/vpc"
  project_name        = var.project_name
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
  az                  = var.availability_zone
}

module "alb_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 5.0"
  name        = "${var.project_name}-alb-sg"
  description = "Allow HTTP"
  vpc_id      = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
    }
  ]

  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
}

module "ecs_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 5.0"
  name        = "${var.project_name}-ecs-sg"
  description = "Allow traffic from ALB"
  vpc_id      = module.vpc.vpc_id

  ingress_with_source_security_group_id = [
    {
      from_port                = 80
      to_port                  = 80
      protocol                 = "tcp"
      source_security_group_id = module.alb_sg.security_group_id
    }
  ]

  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
}

module "iam" {
  source       = "./modules/iam"
  project_name = var.project_name
}

module "alb" {
  source           = "./modules/alb"
  project_name     = var.project_name
  public_subnet_ids = [module.vpc.public_subnet_id]
  vpc_id           = module.vpc.vpc_id
  alb_sg_id        = module.alb_sg.security_group_id
}

module "ecs" {
  source              = "./modules/ecs"
  project_name        = var.project_name
  image_url           = var.image_url
  execution_role_arn  = module.iam.execution_role_arn
  private_subnet_ids  = [module.vpc.private_subnet_id]
  service_sg_id       = module.ecs_sg.security_group_id
  target_group_arn    = module.alb.target_group_arn
  alb_listener        = module.alb.listener_arn
}

