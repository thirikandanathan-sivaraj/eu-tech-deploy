EU Tech Chamber – DevOps Engineer Technical Assessment

This project demonstrates the deployment and monitoring of a containerized Node.js application using modern DevOps practices. The setup includes:
Application containerization with Docker
Infrastructure provisioning using Terraform
CI/CD using GitHub Actions
Monitoring with Zabbix server and agent on a dedicated EC2 instance


[Local Dev] → Merge to Main Branch → GitHub Repo
                                     ↓
                            GitHub Actions → Docker Hub
                                             ↓
                                  AWS ECS Fargate Service ← ALB ← Internet
                                    ↑
                 Zabbix Agent (on EC2, public subnet) ← Zabbix Server + UI

Application: Node.js app displaying a welcome message with a background image
Deployment: ECS Fargate in public subnet, fronted by Application Load Balancer
Monitoring: Zabbix Server and Agent installed on a separate EC2 in public subnet

--------------------------------------------------------------------------------------------------------------
Tech Stack:
AWS: ECS Fargate, ALB, EC2, IAM, VPC, Security Groups
CI/CD: GitHub Actions
IaC: Terraform (modular)
Monitoring: Zabbix (v6.x)
Docker: Node.js app image on Docker Hub

Setup Instructions

1. Clone the Repository
git clone https://github.com/thirikandanathan-sivaraj/eu-tech-deploy.git
cd eu-tech-deploy
--------------------------------------------------------------------------------------------------------------
2. Terraform App Deployment (ECS)
cd terraform
terraform init
terraform plan -var="image_url=thirishhub/basic_node_application:v01"
terraform apply -var="image_url=thirishhub/basic_node_application:v01"

Creates VPC, subnets, ALB, security groups, IAM, ECS cluster & service
Deploys the app in ECS (Fargate) with Docker image from Docker Hub
--------------------------------------------------------------------------------------------------------------

3. Terraform Monitoring Deployment (Zabbix EC2)

cd ../terraform-vm
terraform init
terraform plan \
  -var="key_name=create your vm key" \
  -var="vpc_id=vpc-xxxxxxxx" \
  -var="public_subnet_id=subnet-xxxxxxxx"
terraform apply \
  -var="key_name=create your vm key" \
  -var="vpc_id=vpc-xxxxxxxx" \
  -var="public_subnet_id=subnet-xxxxxxxx"

Provisions EC2 in a public subnet
Installs Zabbix Server, Agent, Apache, MySQL via user_data
Links frontend to Apache automatically
--------------------------------------------------------------------------------------------------------------

4.AWS Configuration:
Before running Terraform or using AWS CLI locally, configure your credentials:

aws configure

Provide:
AWS Access Key ID
AWS Secret Access Key
Default region name: us-east-1
Output format (optional): json
--------------------------------------------------------------------------------------------------------------

5.CI/CD Pipeline (GitHub Actions)
Located at .github/workflows/deploy.yml.
Triggered on every push to main branch:
Build Docker image
Push to Docker Hub

Update ECS service automatically (zero downtime)

Secrets Used In Repo:
DOCKERHUB_USERNAME
DOCKERHUB_TOKEN
AWS_ACCESS_KEY_ID
AWS_SECRET_ACCESS_KEY

These AWS credentials must have permissions to update ECS services and access ECR (if used).

--------------------------------------------------------------------------------------------------------------
6.Monitoring with Zabbix:
EC2 instance (Ubuntu 22.04) hosts both Zabbix Server and Agent
Accessible at: http://<ec2-public-ip>/zabbix
Default credentials:
Username: Admin
Password: zabbix
Monitored: CPU, Memory, Disk usage of the same instance

Thirikandanathan Sivaraj
DevOps|Cloud Engineer 
