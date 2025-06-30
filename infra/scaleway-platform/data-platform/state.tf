terraform {
  backend "s3" {
    bucket                      = var.bucket_name
    key                         = "default.tfstate"
    region                      = local.region
    endpoint                    = "https://s3.nl-ams.scw.cloud"
    skip_credentials_validation = true
    skip_region_validation      = true
  }
}