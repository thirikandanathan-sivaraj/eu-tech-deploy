output "zabbix_instance_public_ip" {
  value       = aws_instance.zabbix.public_ip
  description = "Public IP of the Zabbix EC2 instance"
}

output "zabbix_url" {
  value       = "http://${aws_instance.zabbix.public_ip}"
  description = "Zabbix Web UI URL"
}
