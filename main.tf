terraform {
  required_providers {
    kubernetes = { source = "hashicorp/kubernetes", version = "~> 2.33" }
    helm       = { source = "hashicorp/helm", version = "~> 2.13" }
  }
}


resource "helm_release" "argocd" {
  name             = "argocd-${var.cluster_name}"
  namespace        = "argocd-${var.cluster_name}"
  create_namespace = true

  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = var.chart_version

  values  = [file("${path.module}/argocd-dev.yaml")]
  timeout = 600
  wait    = true
}



# # ArgoCD в DEV
# resource "helm_release" "argocd_dev" {
#   provider         = helm.dev
#   name             = "argocd-dev"
#   repository       = "https://argoproj.github.io/argo-helm"
#   chart            = "argo-cd"
#   namespace        = "argocd-dev"
#   version          = var.chart_version
#   create_namespace = true
#   values           = [file("${path.module}/argocd-dev.yaml")]
#   timeout          = 600
#   wait             = true
# }

# # ArgoCD в PROD
# resource "helm_release" "argocd_prod" {
#   provider         = helm.prod
#   name             = "argocd-prod"
#   repository       = "https://argoproj.github.io/argo-helm"
#   chart            = "argo-cd"
#   namespace        = "argocd-prod"
#   version          = var.chart_version
#   create_namespace = true
#   values           = [file("${path.module}/argocd-prod.yaml")]
#   timeout          = 600
#   wait             = true
# }
