output "alb_dns_name" {
  value = module.alb.alb_dns_name
}

output "ecs_cluster" {
  value = module.ecs.cluster_name
}

