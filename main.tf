locals {
  metrics_server_helm_version = var.metrics_server_helm_version
  metrics_server_namespace    = var.metrics_server_namespace
  metrics_server_helm_repo    = var.metrics_server_helm_repo

  metrics_server_settings_final = merge(
    { "image.tag" = "${var.metrics_server_version}" },
    var.metrics_server_settings
  )
}

resource "helm_release" "metrics_server" {
  name             = "metrics-server"
  repository       = local.metrics_server_helm_repo
  chart            = "metrics-server"
  version          = local.metrics_server_helm_version
  create_namespace = true
  namespace        = local.metrics_server_namespace

  dynamic "set" {
    for_each = local.metrics_server_settings_final
    content {
      name  = set.key
      value = set.value
    }
  }
}