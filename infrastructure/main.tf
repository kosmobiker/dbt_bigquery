provider "google" {
  credentials = file("terraform.json")
  project     = "maximal-storm-391319"
  region      = "europe-north1"
}

resource "google_storage_bucket" "my_bucket" {
  name          = "raw_data_dbt_big_query_lab"
  location      = "europe-north1"
  force_destroy = true
}

resource "google_bigquery_dataset" "my_bigquery_dataset" {
  dataset_id                  = "landing"
  location                    = "europe-north1"
  default_table_expiration_ms = 2592000000
  description                 = "This is a dataset for landing data"
}

resource "google_bigquery_dataset" "my_bigquery_dataset_tr" {
  dataset_id                  = "transform"
  location                    = "europe-north1"
  default_table_expiration_ms = 2592000000
  description                 = "This is a dataset for transformed data"
}

resource "google_bigquery_dataset" "my_bigquery_dataset_pub" {
  dataset_id                  = "public"
  location                    = "europe-north1"
  default_table_expiration_ms = 2592000000
  description                 = "This is a dataset for public data (deployment)"
}

resource "google_compute_instance" "airflow" {
  name         = "airflow-machine"
  machine_type = "n2-standard-2"
  zone         = "europe-north1-a"

  tags = ["airflow"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = "default"
    access_config {
    }
  }

  metadata = {
    ssh-keys = "kosmobiker:${file("../../../.ssh/airflow-key.pub")}"
  }

  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }

  lifecycle {
    ignore_changes = [metadata]
  }

  metadata_startup_script = "${file("airflow-instance.sh")}"
}

resource "google_compute_firewall" "ssh" {
  name    = "allow-ssh"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags = ["airflow"]
}

resource "google_compute_firewall" "http" {
  name    = "allow-http"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["8080"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags = ["airflow"]
}

output "instance_ip" {
  value = google_compute_instance.airflow.network_interface.0.access_config.0.nat_ip
}