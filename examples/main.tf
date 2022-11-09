locals {
  kubeconfig_path = "~/.kube/config"

  metrics_server_helm_version = "3.8.2"
  metrics_server_version      = "v0.6.0"

  metrics_server_settings = {
    "podAnnotations.custom\\.annotation\\.io" = "test"
    "podAnnotations.environment"              = "test"
    "metrics.enabled"                         = "true"
    "args[0]"                                 = "--kubelet-insecure-tls"
    "args[1]"                                 = "--kubelet-preferred-address-types=InternalIP"
  }
}

provider "kubernetes" {
  config_path = local.kubeconfig_path
}

provider "helm" {
  kubernetes {
    config_path = local.kubeconfig_path
  }
}

module "metrics_server" {
  source = "./.."

  metrics_server_helm_version = local.metrics_server_helm_version
  metrics_server_version      = local.metrics_server_version
  metrics_server_settings     = local.metrics_server_settings
}

output "metrics_server_helm_metadata" {
  description = "block status of the metrics-server helm release"
  value       = module.metrics_server.metrics_server_helm_metadata[0]
}