###############################################################################
# AlloyDB Terraform Module — outputs.tf
###############################################################################

output "cluster_id" {
  description = "Fully qualified AlloyDB cluster resource name."
  value       = module.alloy_db.cluster_id
}

output "cluster_name" {
  description = "The resource name of the AlloyDB cluster."
  value       = module.alloy_db.cluster_name
}

output "primary_instance_id" {
  description = "Resource ID of the primary AlloyDB instance."
  value       = module.alloy_db.primary_instance_id
}

output "primary_instance_ip" {
  description = "Private IP address to connect to the primary instance."
  value       = module.alloy_db.primary_instance_ip
  sensitive   = true
}

output "read_pool_instance_ids" {
  description = "Map of read-pool instance IDs (empty if enable_read_pool = false)."
  value       = module.alloy_db.read_pool_instance_ids
}

output "vpc_network_self_link" {
  description = "Self-link of the VPC network used by AlloyDB."
  value       = google_compute_network.alloydb_network.self_link
}

output "private_ip_alloc_name" {
  description = "Name of the global address allocated for VPC peering."
  value       = google_compute_global_address.private_ip_alloc.name
}

output "subnet_self_link" {
  description = "Self-link of the AlloyDB subnet."
  value       = google_compute_subnetwork.alloydb_subnet.self_link
}
