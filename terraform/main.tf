# 1. Zdroj pro sestavení Docker image
resource "docker_image" "spring_app" {
  name         = var.app_image
  build {
    context    = "../spring-app" # Cesta k adresáři s Dockerfilem
    dockerfile = "Dockerfile"
  }
  keep_locally = true
}

# 2. Zdroj pro nasazení aplikace do Kubernetes (Deployment)
resource "kubernetes_deployment" "spring_app" {
  depends_on = [docker_image.spring_app]

  metadata {
    name = var.app_name
    labels = {
      app = var.app_name
    }
  }

  spec {
    replicas = var.replicas

    selector {
      match_labels = {
        app = var.app_name
      }
    }

    template {
      metadata {
        labels = {
          app = var.app_name
        }
      }

      spec {
        container {
          image = docker_image.spring_app.name
          name  = var.app_name
          ports {
            container_port = var.app_port
          }
          
          # Důležité pro lokální vývoj:
          # Tato politika zajistí, že Kubernetes bude vždy používat lokálně
          # sestavenou image a nebude se ji snažit stáhnout z internetu.
          image_pull_policy = "Never"
        }
      }
    }
  }
}

# 3. Zdroj pro vystavení aplikace (Service)
resource "kubernetes_service" "spring_app" {
  metadata {
    name = var.app_name
  }
  spec {
    selector = {
      app = var.app_name
    }
    port {
      port        = var.app_port
      target_port = var.app_port
    }
    
    # Typ NodePort je ideální pro lokální testování a demonstraci.
    type = "NodePort"
  }
}
