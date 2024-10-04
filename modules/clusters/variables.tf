variable "shards" {
  description = "Mapping of shard names to their assigned namespaces."
  type        = map(list(string))
}

variable "argocd_namespace" {
  description = "The namespace where ArgoCD is deployed."
  type        = string
}

variable "shard_list" {
  description = "List of all shard names."
  type        = list(string)
}
