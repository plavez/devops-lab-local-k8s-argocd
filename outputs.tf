# output "argocd_releases" {
#   description = "Helm/ArgoCD info for dev & prod"
#   value = {
#     dev = {
#       name          = helm_release.argocd_dev.name
#       namespace     = helm_release.argocd_dev.namespace
#       chart_version = helm_release.argocd_dev.metadata[0].version
#       app_version   = helm_release.argocd_dev.metadata[0].app_version
#       revision      = helm_release.argocd_dev.metadata[0].revision
#       status        = helm_release.argocd_dev.status
#     }
#     prod = {
#       name          = helm_release.argocd_prod.name
#       namespace     = helm_release.argocd_prod.namespace
#       chart_version = helm_release.argocd_prod.metadata[0].version
#       app_version   = helm_release.argocd_prod.metadata[0].app_version
#       revision      = helm_release.argocd_prod.metadata[0].revision
#       status        = helm_release.argocd_prod.status
#     }
#   }
# }

output "release_info" {
  value = {
    name          = helm_release.argocd.name
    namespace     = helm_release.argocd.namespace
    chart_version = helm_release.argocd.metadata[0].version
    app_version   = helm_release.argocd.metadata[0].app_version
    revision      = helm_release.argocd.metadata[0].revision
    status        = helm_release.argocd.status
  }
}

