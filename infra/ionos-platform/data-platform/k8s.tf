resource "ionoscloud_k8s_cluster" "dp_cluster" {
  name                  = "dp-ionos-k8s-cluster"
  k8s_version           = "1.34.2" #currently the latest available version in IONOS
  maintenance_window {
    day_of_the_week     = "Sunday"
    time                = "09:00:00Z"
  }
  public = false
  location = "de/fra"
  nat_gateway_ip = ionoscloud_ipblock.db_nlb.ips[0]
}

resource "ionoscloud_k8s_node_pool" "example" {
  datacenter_id         = ionoscloud_datacenter.frankfurt.id
  k8s_cluster_id        = ionoscloud_k8s_cluster.dp_cluster.id
  name                  = "default"
  k8s_version           = ionoscloud_k8s_cluster.dp_cluster.k8s_version
  maintenance_window {
    day_of_the_week     = "Monday"
    time                = "09:00:00Z"
  }
  auto_scaling {
    min_node_count      = 1
    max_node_count      = 3
  }
  #cpu_family            = "[INTEL_XEON, INTEL_SKYLAKE, AMD_EPYC, INTEL_ICELAKE, INTEL_SIERRAFOREST, AMD_TURIN]"
  availability_zone     = "AUTO"
  storage_type          = "SSD"
  node_count            = 1
  cores_count           = 4
  ram_size              = 4096
  storage_size          = 50
  server_type           = "VCPU"
  lans {
    id                  = ionoscloud_lan.frankfurt_private.id
    dhcp                = true
  }
}