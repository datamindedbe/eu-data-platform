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

