resource "kubernetes_secret" "trino_oidc" {
  metadata {
    name      = "trino-oidc"
    namespace = "services"
  }

  data = {
    CLIENT_ID     = zitadel_application_oidc.trino.client_id
    CLIENT_SECRET = zitadel_application_oidc.trino.client_secret

  }

  type = "Opaque"
}

resource "kubernetes_secret" "lakekeeper_oidc" {
  metadata {
    name      = "lakekeeper-oidc"
    namespace = "services"
  }

  data = {
    CLIENT_ID     = zitadel_application_oidc.lakekeeper.client_id
    CLIENT_SECRET = zitadel_application_oidc.lakekeeper.client_secret

  }

  type = "Opaque"
}

