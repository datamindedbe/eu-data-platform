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
  ip_restrictions {
    ip = "0.0.0.0/0"
  }
}

resource "ovh_cloud_project_database_database" "zitadel" {
  name = "zitadel"
  service_name = var.service_name
  engine = ovh_cloud_project_database.pgsqldb.engine
  cluster_id = ovh_cloud_project_database.pgsqldb.id
}

resource "ovh_cloud_project_database_database" "lakekeeper_db" {
  name = "lakekeeper"
  service_name = var.service_name
  engine = ovh_cloud_project_database.pgsqldb.engine
  cluster_id = ovh_cloud_project_database.pgsqldb.id
}

resource "ovh_cloud_project_database_database" "trino_catalog_db" {
  name = "catalog"
  service_name = var.service_name
  engine = ovh_cloud_project_database.pgsqldb.engine
  cluster_id = ovh_cloud_project_database.pgsqldb.id
}

resource "ovh_cloud_project_database_postgresql_user" "user" {
  service_name  = ovh_cloud_project_database.pgsqldb.service_name
  cluster_id    = ovh_cloud_project_database.pgsqldb.id
  name          = "admin"
  roles         = ["replication"]
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
        Host: ${data.ovh_cloud_project_database.pgsqldb.endpoints[0].domain}
        Port: ${data.ovh_cloud_project_database.pgsqldb.endpoints[0].port}
        Database: zitadel
        User:
          Username: ${var.pg_admin_user}
          Password: ${var.pg_admin_password}
          SSL:
            Mode: require
        Admin:
          Username: ${var.pg_admin_user}
          Password: ${var.pg_admin_password}
          ExistingDatabase: defaultdb
          SSL:
            Mode: require
  EOF
  }
  type = "Opaque"
}