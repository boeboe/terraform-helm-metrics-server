# terraform-helm-metrics-server

![Terraform Version](https://img.shields.io/badge/terraform-≥_1.0.0-blueviolet)
[![GitHub tag (latest SemVer)](https://img.shields.io/github/v/tag/boeboe/terraform-helm-metrics-server?label=registry)](https://registry.terraform.io/modules/boeboe/metrics-server/helm)
[![GitHub issues](https://img.shields.io/github/issues/boeboe/terraform-helm-metrics-server)](https://github.com/boeboe/terraform-helm-metrics-server/issues)
[![Open Source Helpers](https://www.codetriage.com/boeboe/terraform-helm-metrics-server/badges/users.svg)](https://www.codetriage.com/boeboe/terraform-helm-metrics-server)
[![MIT Licensed](https://img.shields.io/badge/license-MIT-green.svg)](https://tldrlegal.com/license/mit-license)

This terraform module will deploy [metrics-server](https://github.com/kubernetes-sigs/metrics-server) on any kubernetes cluster, using the official [helm charts](hhttps://artifacthub.io/packages/helm/metrics-server/metrics-server).

| Helm Chart | Repo | Default Values |
|------------|------|--------|
| metrics-server | [repo](hhttps://artifacthub.io/packages/helm/metrics-server/metrics-server) | [values](https://artifacthub.io/packages/helm/metrics-server/metrics-server?modal=values) |

## Usage

``` hcl
provider "kubernetes" {
  config_path    = "~/.kube/config"
}

provider "helm" {
  kubernetes {
    config_path    = "~/.kube/config"
  }
}

module "metrics_server" {
  source  = "boeboe/istio/helm"
  version = "0.0.1"

  metrics_server_helm_version = "3.8.2"
  metrics_server_version      = "0.6.1"

  metrics_server_settings = {
    "podAnnotations.custom\\.annotation\\.io" = "test"
    "podAnnotations.environment"              = "test"
    "metrics.enabled"                         = "true"
    "args[0]"                                 = "--kubelet-insecure-tls"
    "args[1]"                                 = "--kubelet-preferred-address-types=InternalIP"
  }
}

output "metrics_server_helm_metadata" {
  description = "block status of the metrics-server helm release"
  value = module.metrics_server.metrics_server_helm_metadata[0]
}
```

Check the [examples](examples) for more details.

## Inputs

| Name | Description | Type | Default | Required | Remarks |
|------|-------------|------|---------|----------|--------|
| metrics_server_helm_version | metrics-server helm version | string | - | true | |
| metrics_server_version | metrics-server version | string | "" | false | if not specified, use chart appVersion value |
| metrics_server_namespace | metrics-server install namespace | string | "kube-system" | false | |
| metrics_server_helm_repo | metrics-server helm repository | string | "https://istio-release.storage.googleapis.com/charts" | false | |
| metrics_server_settings | metrics-server settings | map | {} | false | |

> **INFO:** metrics-server container versions available at [this](https://github.com/kubernetes-sigs/metrics-server/releases) release section

## Outputs

| Name | Description | Type |
|------|-------------|------|
| metrics_server_helm_metadata | block status of the metrics-server helm release | list |


Example output:

``` hcl
metrics_server_helm_metadata = {
  "app_version" = "0.6.1"
  "chart" = "metrics-server"
  "name" = "metrics-server"
  "namespace" = "kube-system"
  "revision" = 3
  "values" = "{\"args\":[\"--kubelet-insecure-tls\",\"--kubelet-preferred-address-types=InternalIP\"],\"image\":{\"tag\":\"v0.6.0\"},\"metrics\":{\"enabled\":true},\"podAnnotations\":{\"custom.annotation.io\":\"test\",\"environment\":\"test\"}}"
  "version" = "3.8.2"
}
```

## More information

TBC

## License

terraform-helm-metrics-server is released under the **MIT License**. See the bundled [LICENSE](LICENSE) file for details.
