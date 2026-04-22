locals {
    region = "eu-central-4"
}

resource "ionoscloud_s3_bucket" "ionos-data" {
  name       = "ionos-data"
  region = local.region
  tags = {
    terraform = "True"
  }
}

data "ionoscloud_user" "current" {
  email            = "niels.claeys@dataminded.com"
}

resource "ionoscloud_s3_key" "tf_key" {
  user_id                 = data.ionoscloud_user.current.id
  active                  = true
  timeouts {
    create = "10m"
    delete = "10m"
    update = "10m"
  }
}