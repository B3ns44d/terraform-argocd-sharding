variable "namespace_shard_mapping" {
  description = "Mapping of namespaces to their respective shard names."
  type        = map(string)
}

variable "argocd_namespace" {
  description = "The namespace where ArgoCD is deployed."
  type        = string
}
