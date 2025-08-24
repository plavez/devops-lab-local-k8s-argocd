# Module to deploy Higly Availabe ArgoCD via HelmChart to kind-K8S -  Docker Desktop

Example to use:

```
module "argocd" {
  source           = "./terraform_argocd_eks"
  cluster_name = "dev"
  chart_version    = "8.2.1"
}
```

Copyleft (c) by Vladislav Golic.