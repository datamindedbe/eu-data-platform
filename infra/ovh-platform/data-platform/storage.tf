resource "ovh_cloud_project_storage" "storage" {
  service_name = var.service_name
  region_name = "GRA"
  name = "dp-storage"
  versioning = {
    status = "disabled"
  }
}