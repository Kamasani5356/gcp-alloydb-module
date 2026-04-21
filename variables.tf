###############################################################################
# AlloyDB Terraform Module — variables.tf
###############################################################################

# ── Project / Region ──────────────────────────────────────────────────────────
variable "project_id" {
  description = "GCP project ID where AlloyDB resources will be created."
  type        = string
}

variable "region" {
  description = "GCP region for the AlloyDB cluster and instances."
  type        = string
  default     = "us-central1"
}

# ── Networking ────────────────────────────────────────────────────────────────
variable "network_name" {
  description = "Name of the VPC network to create for AlloyDB VPC Peering."
  type        = string
  default     = "alloydb-vpc"
}

variable "subnet_cidr" {
  description = "CIDR block for the AlloyDB subnet (e.g. 10.10.0.0/24)."
  type        = string
  default     = "10.10.0.0/24"
}

# ── Cluster ───────────────────────────────────────────────────────────────────
variable "cluster_id" {
  description = "Unique identifier for the AlloyDB cluster. Used as a resource name prefix."
  type        = string
  default     = "alloydb-cluster"
}

variable "cluster_display_name" {
  description = "Human-readable display name shown in the GCP console."
  type        = string
  default     = "AlloyDB Cluster"
}

variable "cluster_labels" {
  description = "Key-value labels applied to the cluster and all instances."
  type        = map(string)
  default = {
    environment = "dev"
    managed-by  = "terraform"
  }
}

variable "database_version" {
  description = "PostgreSQL major version. Cannot be changed after cluster creation."
  type        = string
  default     = "POSTGRES_15"

  validation {
    condition     = contains(["POSTGRES_14", "POSTGRES_15"], var.database_version)
    error_message = "database_version must be POSTGRES_14 or POSTGRES_15."
  }
}

variable "deletion_protection" {
  description = "When true, Terraform cannot destroy the cluster. Set false only for dev/test."
  type        = bool
  default     = true
}

# ── Credentials ───────────────────────────────────────────────────────────────
variable "db_username" {
  description = "Username for the initial AlloyDB superuser account."
  type        = string
  default     = "alloydb-admin"
}

variable "db_password" {
  description = "Password for the initial AlloyDB superuser. Use Secret Manager or env var TF_VAR_db_password."
  type        = string
  sensitive   = true
}

# ── Primary Instance ──────────────────────────────────────────────────────────
variable "primary_cpu_count" {
  description = "Number of vCPUs for the primary instance."
  type        = number
  default     = 2

  validation {
    condition     = contains([1, 2, 4, 8, 16, 32, 64, 96, 128], var.primary_cpu_count)
    error_message = "primary_cpu_count must be one of [1,2,4,8,16,32,64,96,128]."
  }
}

variable "database_flags" {
  description = "Map of PostgreSQL flags for the primary instance."
  type        = map(string)
  default     = {}
}

# ── Read Pool ─────────────────────────────────────────────────────────────────
variable "enable_read_pool" {
  description = "Set true to create a read-pool instance alongside the primary."
  type        = bool
  default     = false
}

variable "read_pool_node_count" {
  description = "Number of nodes in the read pool. 1 = zonal, 2+ = regional."
  type        = number
  default     = 1
}
