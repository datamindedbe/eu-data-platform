terraform {
  required_providers {
    scaleway = {
      source = "scaleway/scaleway"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.6.3"
    }

  }

  required_version = ">= 0.13"
}

provider "scaleway" {
  zone   = local.zone_1
  region = local.region
  access_key = var.scaleway_key
  secret_key = var.scaleway_secret
}