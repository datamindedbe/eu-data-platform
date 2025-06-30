data "zitadel_org" "default" {
  id = "326815099786429523" # TODO replace with your default ziteadel org ID
}

locals {
  domain = "ovh.playground.dataminded.cloud"
}

resource "zitadel_project" "trino" {
  name   = "trino"
  org_id = data.zitadel_org.default.id
}

resource "zitadel_project" "lakekeeper" {
  name   = "lakekeeper"
  org_id = data.zitadel_org.default.id
}

resource "zitadel_application_oidc" "trino" {
  project_id = zitadel_project.trino.id
  org_id = data.zitadel_org.default.id

  name                      = "trino"
  redirect_uris             = ["https://trino.${local.domain}/oauth2/callback"]
  response_types            = ["OIDC_RESPONSE_TYPE_CODE"]
  grant_types               = ["OIDC_GRANT_TYPE_AUTHORIZATION_CODE"]
  post_logout_redirect_uris = ["http://localhost"]
  dev_mode                  = true
  auth_method_type          = "OIDC_AUTH_METHOD_TYPE_BASIC"
}

resource "zitadel_application_oidc" "lakekeeper" {
  project_id = zitadel_project.lakekeeper.id
  org_id = data.zitadel_org.default.id

  name                      = "lakekeeper"
  redirect_uris             = ["https://lakekeeper.${local.domain}/oauth2/callback"]
  response_types            = ["OIDC_RESPONSE_TYPE_CODE"]
  grant_types               = ["OIDC_GRANT_TYPE_AUTHORIZATION_CODE"]
  post_logout_redirect_uris = ["http://localhost"]
  dev_mode                  = true
  auth_method_type          = "OIDC_AUTH_METHOD_TYPE_BASIC"
}

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
