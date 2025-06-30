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
  project_id = local.project_id
  organization_id = local.organisation_id
}
