locals {
}

resource "ionoscloud_s3_bucket" "ionos-data" {
  name       = "ionos-data"
  region = "eu-central-4"
  tags = {
    terraform = "True"
  }
}