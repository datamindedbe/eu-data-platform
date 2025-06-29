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

data "kubernetes_namespace" "services" {
  metadata {
    name = "services"
  }
}

data "ovh_cloud_project_database" "pgsqldb" {
  service_name = var.service_name
  engine = "postgresql"
  id = ovh_cloud_project_database.pgsqldb.id
}

resource "kubernetes_secret" "zitadel_db" {
  metadata {
    name = "zitadel-credentials"
   namespace = data.kubernetes_namespace.services.metadata[0].name

  }
  //TODO: use TLS
  data = { "config.yaml": <<EOF
    Database:
      Postgres:
        Host: ${data.ovh_cloud_project_database.pgsqldb.endpoints.uri}
        Port: ${data.ovh_cloud_project_database.pgsqldb.endpoints.port}
        Database: zitadel
        User:
          Username: ${ovh_cloud_project_database_postgresql_user.user.name}
          Password: ${ovh_cloud_project_database_postgresql_user.user.password}
          SSL:
            Mode: prefer
        Admin:
          Username: ${ovh_cloud_project_database_postgresql_user.user.name}
          Password: ${ovh_cloud_project_database_postgresql_user.user.password}
          ExistingDatabase: defaultdb
          SSL:
            Mode: prefer
  EOF
  }
  type = "Opaque"
}