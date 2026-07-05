locals {
  service_ingress = try(data.kubernetes_service_v1.app.status[0].load_balancer[0].ingress[0], {})
}

output "load_balancer_ip" {
  description = "Load Balancer IP address or hostname for the AKS service."
  value       = try(local.service_ingress.ip, local.service_ingress.hostname, "")
}
