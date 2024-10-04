locals {
  namespace_shard_mapping = merge([
    for shard_name, namespaces in var.shards :
    {
      for namespace in namespaces :
      namespace => shard_name
    }
  ]...)
}

module "services" {
  source           = "./modules/services"
  shards           = var.shards
  argocd_namespace = var.argocd_namespace
  kube_endpoints   = var.kubernetes_api_endpoints
}

module "rbac" {
  source                  = "./modules/rbac"
  namespace_shard_mapping = local.namespace_shard_mapping
  argocd_namespace        = var.argocd_namespace
}

module "clusters" {
  source           = "./modules/clusters"
  shards           = var.shards
  argocd_namespace = var.argocd_namespace
  shard_list       = var.shard_list
}

resource "kubernetes_manifest" "apply_namespace_shard_assignment" {
  for_each = var.shards

  manifest = yamldecode(templatefile("templates/namespace_shard_assignment.yaml.tpl", {
    shard_name     = each.key,
    namespace_list = each.value
  }))

  depends_on = [module.clusters]
}
