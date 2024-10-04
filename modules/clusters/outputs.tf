output "cluster_names" {
  value = keys(argocd_cluster.clusters)
}
