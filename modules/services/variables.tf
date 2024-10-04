variable "shards" {
  description = "Mapping of shard names to their assigned namespaces."
  type        = map(list(string))
}

variable "argocd_namespace" {
  description = "The namespace where ArgoCD is deployed."
  type        = string
}

variable "kube_endpoints" {
  description = "List of IP addresses for the Kubernetes API endpoints."
  type        = list(string)
}
