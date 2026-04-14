terraform {
  required_providers {
    ionoscloud = {
      source = "ionos-cloud/ionoscloud"
      version = ">= 6.4.10"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.6.3"
    }

  }

  required_version = "~> 1.11"
}

provider "ionoscloud" {
  # token = var.ionos_token We lookat IONOS_TOKEN in env vars
  s3_region = "eu-central-4" #frankfurt region
}