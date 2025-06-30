resource "random_string" "db-pass" {
  length      = 16
  min_lower   = 1
  min_numeric = 1
  min_special = 1
  min_upper   = 1
}

# By default creates a public endpoint, you can also only create a private endpoint if needed.
resource "scaleway_rdb_instance" "main" {
  name               = "dp-scaleway-postgres"
  node_type          = "DB-PLAY2-NANO"
  engine             = "PostgreSQL-15"
  project_id         = local.project_id
  is_ha_cluster      = false
  disable_backup     = true
  encryption_at_rest = true
  user_name          = "admin"
  password           = random_string.db-pass.result
  volume_type        = "sbs_5k"
  volume_size_in_gb  = 5
  private_network {
    pn_id       = scaleway_vpc_private_network.private_1.id
    enable_ipam = true
  }
  load_balancer {}
}

resource "scaleway_rdb_database" "main" {
  name        = "lakekeeper"
  instance_id = scaleway_rdb_instance.main.id
}

resource "scaleway_rdb_privilege" "main" {
  instance_id   = scaleway_rdb_instance.main.id
  user_name     = "admin"
  database_name = scaleway_rdb_database.main.name
  permission    = "all"
}
