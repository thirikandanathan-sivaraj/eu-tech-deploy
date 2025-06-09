provider "aws" {
  region = var.aws_region
}

resource "aws_security_group" "zabbix_sg" {
  name        = "zabbix-sg"
  description = "Allow Zabbix + SSH access"
  vpc_id      = var.vpc_id

  ingress = [
    for port in [22, 80, 10050, 10051] : {
      description      = "Allow port ${port}"
      from_port        = port
      to_port          = port
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]

  egress = [
    {
      description      = "Allow all egress"
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]
}

resource "aws_instance" "zabbix" {
  ami                         = "ami-0fc5d935ebf8bc3bc" # Ubuntu 22.04 LTS (us-east-1)
  instance_type               = "t2.micro"
  subnet_id                   = var.public_subnet_id
  vpc_security_group_ids      = [aws_security_group.zabbix_sg.id]
  key_name                    = var.key_name
  associate_public_ip_address = true

  user_data = <<-EOF
              #!/bin/bash
              apt update
              apt install -y wget apache2 mysql-server php php-mbstring php-gd php-xml php-bcmath php-ldap php-mysql snmp
              wget https://repo.zabbix.com/zabbix/6.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_6.0-4+ubuntu22.04_all.deb
              dpkg -i zabbix-release_6.0-4+ubuntu22.04_all.deb
              apt update
              apt install -y zabbix-server-mysql zabbix-frontend-php zabbix-apache-conf zabbix-sql-scripts zabbix-agent
              systemctl enable apache2 zabbix-server zabbix-agent
              systemctl start apache2 zabbix-server zabbix-agent
              EOF

  tags = {
    Name = "zabbix-monitor"
  }
}
