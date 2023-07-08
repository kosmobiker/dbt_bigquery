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
  default_table_expiration_s  = 7776000000 # 90 days
  deletion_protection         = false
  description                 = "This is a dataset for landing data"
}

resource "google_bigquery_dataset" "my_bigquery_dataset_tr" {
  dataset_id                  = "transform"
  location                    = "europe-north1"
  default_table_expiration_s  = 7776000000 # 90 days
  deletion_protection         = false
  description                 = "This is a dataset for transformed data"
}
