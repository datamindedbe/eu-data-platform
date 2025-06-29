resource "ovh_cloud_project_database" "pgsqldb" {
  service_name  = var.service_name
  description   = "dp"
  engine        = "postgresql"
  version       = "17"
  plan          = "essential"
  nodes {
    region  = "GRA"
  }
  flavor        = "db1-4"
}

resource "ovh_cloud_project_database_database" "zitadel" {
  service_name = var.service_name
  engine = ovh_cloud_project_database.pgsqldb.engine
  cluster_id = ovh_cloud_project_database.pgsqldb.id
  name = "zitadel"
}

resource "ovh_cloud_project_database_postgresql_user" "user" {
  service_name  = ovh_cloud_project_database.pgsqldb.service_name
  cluster_id    = ovh_cloud_project_database.pgsqldb.id
  name          = "admin"
  roles         = ["admin"]
}

output "user_password" {
  value     = ovh_cloud_project_database_postgresql_user.user.password
  sensitive = true
}