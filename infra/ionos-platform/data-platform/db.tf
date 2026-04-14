resource "ionoscloud_pg_cluster" "main" {
  postgres_version = "16"
  display_name = "dp-ionos-cluster"
  location          = "de/fra"
  synchronization_mode  = "ASYNCHRONOUS"
  backup_location   = "de"
  instances = 1
  cores = 2
  ram = 4096
  storage_size = 100240
  storage_type = "HDD"
  connection_pooler {
    enabled = true
    pool_mode = "session"
  }

  connections {
    datacenter_id            = ionoscloud_datacenter.frankfurt.id
    lan_id                   = ionoscloud_lan.frankfurt_private.id
    cidr = "192.168.1.100/24"
  }

  maintenance_window {
    time            = "09:00:00"
    day_of_the_week = "Sunday"
  }

  credentials {
    username = "dpadmin"
    password = random_password.cluster_password.result
  }
}

/*
I do not know the target IP, so skip it for now, let's see if it works later.
resource "ionoscloud_networkloadbalancer" "expose_db" {
  datacenter_id           = ionoscloud_datacenter.frankfurt.id
  name                    = "db-lb"
  ips = ionoscloud_ipblock.db_nlb.ips
  listener_lan            = ionoscloud_lan.frankfurt_public.id
  target_lan              = ionoscloud_lan.frankfurt_private.id
  central_logging         = false #central logging is not available in Frankfurt
}

resource "ionoscloud_networkloadbalancer_forwardingrule" "db" {
  algorithm              = "ROUND_ROBIN"
  datacenter_id          = ionoscloud_datacenter.frankfurt.id
  listener_port          = 5432
  listener_ip = ionoscloud_ipblock.db_nlb.ips[0]
  name                   = "forward-db"
  networkloadbalancer_id = ionoscloud_networkloadbalancer.expose_db.id
  protocol               = "TCP"
  targets {
    ip                      = ionoscloud_pg_cluster.main
    port                    = "5432"
    weight                  = "1"
    proxy_protocol          = "none"
  }
}*/

resource "ionoscloud_pg_database" "zitadel" {
  name = "zitadel"
  cluster_id = ionoscloud_pg_cluster.main.id
  owner = ionoscloud_pg_cluster.main.credentials[0].username
}

resource "ionoscloud_pg_database" "lakekeeper_db" {
  name = "lakekeeper"
  cluster_id = ionoscloud_pg_cluster.main.id
  owner = ionoscloud_pg_cluster.main.credentials[0].username
}

resource "ionoscloud_pg_database" "trino_catalog_db" {
  name = "catalog"
  cluster_id = ionoscloud_pg_cluster.main.id
  owner = ionoscloud_pg_cluster.main.credentials[0].username
}

resource "random_password" "cluster_password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}
