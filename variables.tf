variable "cluster_name" {
  description = "Cluster name to deploy ArgoCD"
  type        = string

}

# variable "chart_version_dev" {
#   description = "Helm Chart Version of ArgoCD: https://github.com/argoproj/argo-helm/releases"
#   type        = string
#   default     = "8.2.5"

# }
# variable "chart_version_prod" {
#   description = "Helm Chart Version of ArgoCD: https://github.com/argoproj/argo-helm/releases"
#   type        = string
#   default     = "8.2.3"

# }
variable "chart_version" {
  description = "Helm Chart Version of ArgoCD: https://github.com/argoproj/argo-helm/releases"
  type        = string

}

variable "values_file" {
  description = "Values of File"
  type        = string
  default     = ""
}
