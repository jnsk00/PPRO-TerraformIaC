variable "app_name" {
  description = "Název aplikace, použitý pro labely a názvy zdrojů."
  type        = string
  default     = "spring-app-demo"
}

variable "app_image" {
  description = "Název Docker image pro aplikaci."
  type        = string
  default     = "spring-app-demo:latest"
}

variable "app_port" {
  description = "Port, na kterém aplikace běží uvnitř kontejneru."
  type        = number
  default     = 8080
}

variable "replicas" {
  description = "Počet replik aplikace v Kubernetes."
  type        = number
  default     = 2
}
