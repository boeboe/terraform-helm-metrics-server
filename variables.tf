variable "metrics_server_helm_version" {
  description = "metrics-server helm version"
  type        = string
}

variable "metrics_server_version" {
  description = "metrics-server version"
  type        = string
}

variable "metrics_server_namespace" {
  description = "metrics-server install namespace"
  type        = string
  default     = "kube-system"
}

variable "metrics_server_helm_repo" {
  description = "metrics-server helm repository"
  type        = string
  default     = "https://kubernetes-sigs.github.io/metrics-server"
}


variable "metrics_server_settings" {
  description = "metrics-server base settings"
  type        = map(any)
  default     = {}
}
