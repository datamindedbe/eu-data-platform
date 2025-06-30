provider "zitadel" {
  # Configuration options
  domain           = "zitadel.ovh.playground.dataminded.cloud"
  insecure         = "true"
  jwt_profile_file = "token.json"
}

terraform {
  required_providers {
    zitadel = {
      source  = "zitadel/zitadel"
      version = "2.2.0"
    }
  }
}

provider "kubernetes" {
  config_path = "../k8s/.kubeconfig.yml"
}
