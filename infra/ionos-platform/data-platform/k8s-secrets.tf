resource "kubernetes_secret" "s3_credentials" {
  metadata {
    name      = "s3-credentials"
    namespace = kubernetes_namespace.services.metadata[0].name
  }

  data = {
    ACCESS_KEY_ID     = ionoscloud_s3_key.tf_key.id
    SECRET_ACCESS_KEY = ionoscloud_s3_key.tf_key.secret_key
    ENDPOINT          = "https://s3.${local.region}.ionoscloud.com"
    REGION            = local.region
  }

  type = "Opaque"
}

resource "kubernetes_secret" "zitadel_db" {
  metadata {
    name = "zitadel-credentials"
    namespace = kubernetes_namespace.services.metadata[0].name

  }
  //TODO: use TLS
  data = { "config.yaml": <<EOF
    Database:
      Postgres:
        Host: ${ionoscloud_pg_cluster.main.dns_name}
        Port: "5432"
        Database: zitadel
        User:
          Username: ${ionoscloud_pg_cluster.main.credentials[0].username}
          Password: ${ionoscloud_pg_cluster.main.credentials[0].password}
          SSL:
            Mode: prefer
        Admin:
          Username: ${ionoscloud_pg_cluster.main.credentials[0].username}
          Password: ${ionoscloud_pg_cluster.main.credentials[0].password}
          ExistingDatabase: zitadel
          SSL:
            Mode: prefer
  EOF
  }
  type = "Opaque"

}

resource "kubernetes_secret" "pg_credentials" {
  metadata {
    name      = "pg-credentials"
    namespace = kubernetes_namespace.services.metadata[0].name
  }

  data = {
    USERNAME = ionoscloud_pg_cluster.main.credentials[0].username
    PASSWORD = ionoscloud_pg_cluster.main.credentials[0].password
    HOST     = ionoscloud_pg_cluster.main.dns_name
    PORT     = "5432"
    URI      = "jdb:postgresql://${ionoscloud_pg_cluster.main.dns_name}"
  }
  type = "Opaque"
}
/*
Didn't figure out how to extract this
resource "kubernetes_secret" "db_certficate" {
  metadata {
    name      = "pg-certificate"
    namespace = kubernetes_namespace.services.metadata[0].name
  }

  data = {
    "ca.crt" = ionoscloud_pg_cluster.main.certificate
  }
  type = "Opaque"
}*/


resource "kubernetes_secret" "database_secrets" {
  metadata {
    name = "lakekeeper-custom-secrets"
    namespace = "services"
  }
  data = {
    ICEBERG_REST__PG_HOST_R=ionoscloud_pg_cluster.main.dns_name
    ICEBERG_REST__PG_HOST_W=ionoscloud_pg_cluster.main.dns_name
    ICEBERG_REST__PG_PORT="5432"
    ICEBERG_REST__PG_PASSWORD=ionoscloud_pg_cluster.main.credentials[0].password
    ICEBERG_REST__PG_DATABASE=ionoscloud_pg_database.lakekeeper_db.name
    ICEBERG_REST__PG_USER=ionoscloud_pg_cluster.main.credentials[0].username
    ICEBERG_REST__SECRETS_BACKEND="Postgres"
    LAKEKEEPER__AUTHZ_BACKEND="allowall"
  }
  depends_on = [kubernetes_namespace.services]
}