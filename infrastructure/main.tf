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

resource "google_bigquery_dataset" "my_dataset_super_test_161" {
  dataset_id                  = "terraform_test_schema"
  location                    = "europe-north1"
  default_table_expiration_ms = 3600000
}
