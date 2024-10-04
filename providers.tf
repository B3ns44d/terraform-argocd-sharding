terraform {
  required_version = "=1.8.5"
  required_providers {
    argocd = {
      source  = "oboukili/argocd"
      version = "6.1.1"
    }
    kubernetes = {
      version = "=2.31.0"
    }
  }
}


provider "kubernetes" {
  host  = var.kubernetes_host
  token = var.kubernetes_token
}

provider "argocd" {
  server_addr = var.argocd_server_addr
  username    = var.argocd_username
  password    = var.argocd_password
  grpc_web    = true
}