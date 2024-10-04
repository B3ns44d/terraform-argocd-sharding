resource "kubernetes_role_v1" "namespace_role" {
  for_each = var.namespace_shard_mapping
  metadata {
    name      = "role-${each.key}"
    namespace = each.key
  }
  rule {
    api_groups = ["*"]
    resources  = ["*"]
    verbs      = ["*"]
  }
}

resource "kubernetes_role_binding_v1" "namespace_role_binding" {
  for_each = var.namespace_shard_mapping
  metadata {
    name      = "rb-${each.key}"
    namespace = each.key
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = "role-${each.key}"
  }
  subject {
    kind      = "ServiceAccount"
    name      = each.value
    namespace = var.argocd_namespace
  }
}
