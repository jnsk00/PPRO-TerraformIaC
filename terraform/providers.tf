terraform {
  required_version = ">= 1.3.0"

  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.2"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.27.0"
    }
  }
}

provider "docker" {}

provider "kubernetes" {
  # Windows cesta k kubeconfigu (Terraform si ~ přeloží na C:\Users\TvojeJmeno\...)
  config_path    = pathexpand("~/.kube/config")

  # přesně ten context, co ti vypsalo:
  # CURRENT   NAME             CLUSTER          AUTHINFO         NAMESPACE
  # *         docker-desktop   docker-desktop   docker-desktop
  config_context = "docker-desktop"
}
