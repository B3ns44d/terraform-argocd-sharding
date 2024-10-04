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