terraform {
  backend "s3" {
    bucket                      = var.bucket_name
    key                         = "default.tfstate"
    region                      = "eu-central-4"
    skip_credentials_validation = true
    skip_region_validation      = true
    skip_requesting_account_id  = true
    endpoint                    = "https://s3.eu-central-4.ionoscloud.com"
  }
}