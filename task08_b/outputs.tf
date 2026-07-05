output "aca_fqdn" {
  description = "FQDN of the application deployed to Azure Container Apps."
  value       = module.aca.fqdn
}

output "aks_lb_ip" {
  description = "Load Balancer IP address of the application deployed to AKS."
  value       = module.k8s.load_balancer_ip
}

output "redis_fqdn" {
  description = "FQDN of the Redis Azure Container Instance."
  value       = module.aci_redis.redis_fqdn
}
