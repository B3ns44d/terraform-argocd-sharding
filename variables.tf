variable "shards" {
  description = "Mapping of shard names to their assigned namespaces."
  type        = map(list(string))
}

variable "shard_list" {
  description = "List of all shard names."
  type        = list(string)
}

variable "argocd_namespace" {
  description = "The namespace where ArgoCD is deployed."
  type        = string
  default     = "argocd"
}

variable "kubernetes_api_endpoints" {
  description = "List of IP addresses for the Kubernetes API endpoints."
  type        = list(string)
}

variable "kubernetes_host" {
  description = "Kubernetes API server endpoint"
  type        = string
}

variable "kubernetes_token" {
  description = "Token for authentication to the Kubernetes API"
  type        = string
}

variable "argocd_server_addr" {
  description = "ArgoCD server address"
  type        = string
}

variable "argocd_username" {
  description = "Username for ArgoCD authentication"
  type        = string
}

variable "argocd_password" {
  description = "Password for ArgoCD authentication"
  type        = string
}