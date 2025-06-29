# terraform {
#   required_providers {
#     zitadel = {
#       source  = "zitadel/zitadel"
#       version = "2.2.0"
#     }
#   }
# }
#
# provider "zitadel" {
#   # Configuration options
#   domain           = "zitadel.ovh.playground.dataminded.cloud"
#   insecure         = "true"
#   jwt_profile_file = "token.json"
#   # token = "token.json"
# }

terraform {
  required_providers {
    ovh = {
      source = "ovh/ovh"
      version = "2.4.0"
    }
  }
}

provider "ovh" {
  # Configuration options
  endpoint = "ovh-eu"
}

provider "kubernetes" {
  config_path = "../k8s/.kubeconfig.yml"
}

