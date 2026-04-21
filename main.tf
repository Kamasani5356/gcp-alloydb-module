resource "google_alloydb_cluster" "cluster" {
  project  = var.project_id
  cluster_id = var.cluster_id
  location = var.region

  display_name = var.cluster_display_name
  database_version = var.database_version
  deletion_protection = var.deletion_protection

  network_config {
    network = "projects/${var.project_id}/global/networks/${google_compute_network.alloydb_network.name}"
  }

  initial_user {
    user     = var.db_username
    password = var.db_password
  }

  automated_backup_policy {
    enabled        = true
    backup_window  = "1800s"
    location       = var.region

    weekly_schedule {
      days_of_week = ["FRIDAY"]
      start_times  = ["02:00:00"]
    }

    quantity_based_retention {
      count = 7
    }

    labels = {
      managed-by = "terraform"
    }
  }

  continuous_backup_config {
    enabled              = true
    recovery_window_days = 14
  }

  labels = var.cluster_labels

  depends_on = [
    google_service_networking_connection.vpc_peering
  ]
}
