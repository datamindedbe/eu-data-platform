locals {
  region = "DE1"
  cluster_name = "dp-k8s"
}

resource "ovh_cloud_project_kube" "cluster" {
  service_name = var.service_name
  name         = local.cluster_name
  region       = local.region
  version      = "1.32"
}

resource "ovh_cloud_project_kube_nodepool" "node_pool" {
  service_name  = var.service_name
  kube_id       = ovh_cloud_project_kube.cluster.id
  name          = "default-pool"
  flavor_name   = "d2-4"
  desired_nodes = 3
  min_nodes     = 1
  max_nodes     = 5
  autoscale     = true
  anti_affinity = false
  autoscaling_scale_down_unneeded_time_seconds = 600
  autoscaling_scale_down_unready_time_seconds = 300
  autoscaling_scale_down_utilization_threshold = 0.2
}

output "kubeconfig" {
  value       = ovh_cloud_project_kube.cluster.kubeconfig
  sensitive   = true
  description = "Kubernetes cluster kubeconfig"
}

output "cluster_url" {
  value       = ovh_cloud_project_kube.cluster.url
  description = "Kubernetes cluster API URL"
}

resource "local_file" "kubeconfig" {
  content  = ovh_cloud_project_kube.cluster.kubeconfig
  filename = "${path.module}/.kubeconfig.yml"
  file_permission = "0600"  # Secure permissions for the kubeconfig file
}