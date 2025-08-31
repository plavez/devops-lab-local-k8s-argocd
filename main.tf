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

resource "helm_release" "metrics_server" {
  name       = "metrics-server"
  namespace  = "kube-system"
  repository = "https://kubernetes-sigs.github.io/metrics-server/"
  chart      = "metrics-server"
  version    = "3.12.2"

  set {
    name  = "args"
    value = "{--kubelet-insecure-tls,--kubelet-preferred-address-types=InternalIP,Hostname,InternalDNS,ExternalDNS,ExternalIP}"
  }
}

# resource "kubernetes_namespace" "monitoring_dev" {
#   provider = kubernetes.dev
#   metadata {
#     name = "monitoring"
#   }
# }

# ## Kubernetes Dashboard
# resource "helm_release" "dashboard" {
#   name             = "kubernetes-dashboard"
#   namespace        = "kubernetes-dashboard"
#   create_namespace = true

#   repository = "https://kubernetes.github.io/dashboard/"
#   chart      = "kubernetes-dashboard"
#   version    = "7.12.0"


#   set {
#     name  = "serviceAccount.create"
#     value = true
#   }
#   set {
#     name  = "serviceAccount.name"
#     value = "dashboard-sa"
#   }
# }

# resource "kubernetes_service_account" "dash_editor" {
#   metadata {
#     name      = "dash-editor"
#     namespace = "kubernetes-dashboard"
#   }
#   depends_on = [helm_release.dashboard]
# }

# resource "kubernetes_cluster_role_binding" "dash_editor" {
#   metadata {
#     name = "dash-editor-binding"
#   }
#   role_ref {
#     api_group = "rbac.authorization.k8s.io"
#     kind      = "ClusterRole"
#     name      = "edit"
#   }
#   subject {
#     kind      = "ServiceAccount"
#     name      = kubernetes_service_account.dash_editor.metadata[0].name
#     namespace = "kubernetes-dashboard"
#   }
# }

# resource "kubernetes_cluster_role" "dash_cluster_read" {
#   metadata { name = "dash-cluster-read" }
#   rule {
#     api_groups = [""]
#     resources  = ["nodes", "namespaces"]
#     verbs      = ["get", "list", "watch"]
#   }
#   # (опционально, чтобы работали метрики в обзоре)
#   rule {
#     api_groups = ["metrics.k8s.io"]
#     resources  = ["nodes", "pods"]
#     verbs      = ["get", "list", "watch"]
#   }
# }

# resource "kubernetes_cluster_role_binding" "dash_cluster_read" {
#   metadata { name = "dash-cluster-read-binding" }
#   role_ref {
#     api_group = "rbac.authorization.k8s.io"
#     kind      = "ClusterRole"
#     name      = kubernetes_cluster_role.dash_cluster_read.metadata[0].name
#   }
#   subject {
#     kind      = "ServiceAccount"
#     name      = kubernetes_service_account.dash_editor.metadata[0].name
#     namespace = kubernetes_service_account.dash_editor.metadata[0].namespace
#   }
# }
