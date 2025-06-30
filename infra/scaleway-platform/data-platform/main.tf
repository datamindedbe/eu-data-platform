locals {
  project_id = "b8e0510f-f68b-4139-8356-9bd7c11164e8"
  organisation_id = "b8e0510f-f68b-4139-8356-9bd7c11164e8"
  region     = "nl-ams"
  zone_1     = "nl-ams-1"
  tags       = ["terraform", "demo"]
}

resource "scaleway_object_bucket" "scaleway-data" {
  name       = "scaleway-data"
  project_id = local.project_id
  tags = {
    terraform = "True"
  }
}

resource "scaleway_iam_application" "blob_access" {
  name = "blob-admin"
}

resource "scaleway_iam_api_key" "main" {
  application_id = scaleway_iam_application.blob_access.id
  description    = "Keys to read data from blob storage"
}

resource scaleway_iam_policy "object_read_only" {
  name           = "read-write-data"
  description    = "gives app readonly access to object storage in project"
  application_id = scaleway_iam_application.blob_access.id
  rule {
    project_ids = [local.project_id]
    permission_set_names = ["ObjectStorageFullAccess"]
  }
}
