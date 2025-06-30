resource "scaleway_k8s_cluster" "k8s" {
  cni                         = "cilium"
  delete_additional_resources = false
  name                        = "scaleway-k8s-cluster"
  version                     = "1.32.3"
  private_network_id = scaleway_vpc_private_network.private_1.id
}

resource "scaleway_k8s_pool" "pool" {
  cluster_id = scaleway_k8s_cluster.k8s.id
  name       = "default-pool"
  node_type  = "DEV1-L"
  size       = 2
}

resource "local_sensitive_file" "kubeconfig" {
  filename        = "${path.module}/.kubeconfig.yml"
  content         = scaleway_k8s_cluster.k8s.kubeconfig[0].config_file
  file_permission = "0600"
}

provider "kubernetes" {
  config_path = local_sensitive_file.kubeconfig.filename
}

resource "kubernetes_namespace" "services" {
  metadata {
    name = "services"
  }
}

resource "kubernetes_namespace" "traefik" {
  metadata {
    name = "traefik"
  }

  depends_on = [scaleway_k8s_pool.pool]
}

resource "kubernetes_namespace" "opa" {
  metadata {
    name = "opa"
  }

  depends_on = [scaleway_k8s_pool.pool]
}
