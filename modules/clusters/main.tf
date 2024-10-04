resource "kubernetes_service_account_v1" "shard_service_account" {
  for_each = var.shards
  metadata {
    name      = each.key
    namespace = var.argocd_namespace
  }
}

resource "kubernetes_secret_v1" "shard_service_account_secret" {
  for_each = var.shards
  metadata {
    name      = "${each.key}-token"
    namespace = var.argocd_namespace
    annotations = {
      "kubernetes.io/service-account.name" = each.key
    }
  }
  type                           = "kubernetes.io/service-account-token"
  wait_for_service_account_token = true
  depends_on = [
    kubernetes_service_account_v1.shard_service_account
  ]
}

data "kubernetes_secret_v1" "shard_service_account_tokens" {
  for_each = var.shards
  metadata {
    name      = "${each.key}-token"
    namespace = var.argocd_namespace
  }
  depends_on = [
    kubernetes_secret_v1.shard_service_account_secret
  ]
}

resource "argocd_cluster" "clusters" {
  for_each   = var.shards
  server     = "https://${each.key}.${var.argocd_namespace}.svc"
  name       = each.key
  namespaces = each.value
  shard      = index(var.shard_list, each.key)
  config {
    bearer_token = data.kubernetes_secret_v1.shard_service_account_tokens[each.key].data["token"]
    tls_client_config {
      insecure = true
    }
  }
}
