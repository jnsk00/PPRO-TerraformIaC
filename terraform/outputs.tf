output "app_name" {
  description = "Název nasazené aplikace."
  value       = kubernetes_deployment.spring_app.metadata[0].name
}

output "kubernetes_service_name" {
  description = "Název Kubernetes služby."
  value       = kubernetes_service.spring_app.metadata[0].name
}

output "service_node_port" {
  description = "Port, na kterém je služba vystavena na uzlu clusteru (NodePort)."
  value       = kubernetes_service.spring_app.spec[0].port[0].node_port
}

output "access_url_hint" {
    description = "Nápověda pro přístup k aplikaci."
    value = "Pro přístup k aplikaci použijte IP adresu vašeho Kubernetes clusteru (např. Minikube IP) a port: ${kubernetes_service.spring_app.spec[0].port[0].node_port}. Např. http://<minikube_ip>:${kubernetes_service.spring_app.spec[0].port[0].node_port}"
}
