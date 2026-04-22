resource "random_string" "random" {
  length  = 16
  special = false
  upper   = false
}

resource "ionoscloud_s3_bucket" "state" {
  name   = "dp-stack-tf-state-${random_string.random.result}"
  region = "eu-central-4"
}