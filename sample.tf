###############################################################################
# AlloyDB Terraform Module — sample.tfvars
# Usage : terraform apply -var-file=sample.tfvars
# Note  : Never commit db_password. Use TF_VAR_db_password env variable.
###############################################################################

# ── Project / Region ──────────────────────────────────────────────────────────
project_id = "my-gcp-project-id"   # <-- replace with your GCP Project ID
region     = "us-central1"

# ── Networking ────────────────────────────────────────────────────────────────
network_name = "alloydb-vpc"
subnet_cidr  = "10.10.0.0/24"

# ── Cluster ───────────────────────────────────────────────────────────────────
cluster_id           = "alloydb-cluster-prod"
cluster_display_name = "Production AlloyDB Cluster"
database_version     = "POSTGRES_15"
deletion_protection  = true

cluster_labels = {
  environment = "production"
  team        = "data-platform"
  managed-by  = "terraform"
}

# ── Credentials ───────────────────────────────────────────────────────────────
db_username = "alloydb-admin"
db_password = "Ch@ngeMe!2025"   # prefer: export TF_VAR_db_password="..."

# ── Primary Instance ──────────────────────────────────────────────────────────
primary_cpu_count = 4

database_flags = {
  "max_connections" = "500"
  "work_mem"        = "16384"   # 16 MB expressed in kB
  "log_min_duration_statement" = "1000"  # log queries > 1 s
}

# ── Read Pool (optional) ──────────────────────────────────────────────────────
enable_read_pool     = true
read_pool_node_count = 2   # 2 nodes = regional (HA) read pool
