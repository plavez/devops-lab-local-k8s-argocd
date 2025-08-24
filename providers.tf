provider "kubernetes" {
  alias          = "dev"
  config_path    = "~/.kube/config"
  config_context = "kind-dev"

}

provider "helm" {
  alias = "dev"
  kubernetes {
    config_path    = "~/.kube/config"
    config_context = "kind-dev"
  }

}
provider "kubernetes" {
  alias          = "prod"
  config_path    = "~/.kube/config"
  config_context = "kind-prod"

}

provider "helm" {
  alias = "prod"
  kubernetes {
    config_path    = "~/.kube/config"
    config_context = "kind-prod"
  }

}
