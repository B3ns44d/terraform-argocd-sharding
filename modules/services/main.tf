resource "kubernetes_service_v1" "shard_service" {
  for_each = var.shards
  metadata {
    name      = each.key
    namespace = var.argocd_namespace
  }
  spec {
    port {
      port        = 443
      target_port = 6443
      protocol    = "TCP"
      name        = "https"
    }
  }
}

resource "kubernetes_endpoint_slice_v1" "shard_endpoint_slice" {
  for_each = var.shards
  metadata {
    name      = each.key
    namespace = var.argocd_namespace
    labels = {
      "kubernetes.io/service-name" = each.key
    }
  }
  endpoint {
    addresses = var.kube_endpoints
  }
  port {
    port         = 6443
    name         = "https"
    protocol     = "TCP"
    app_protocol = "TCP"
  }
  address_type = "IPv4"
}
