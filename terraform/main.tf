provider "google" {
  project = var.project_id
  region  = var.region
  credentials = file(var.secret_key)
  
}

resource "google_storage_bucket" "gcs_bucket" {
  name          = var.bucket_name
  location      = var.region
  force_destroy = true  
  uniform_bucket_level_access = true
}


resource "google_bigquery_dataset" "stg_dataset" {
  dataset_id                  = var.stg_dataset_id
  location                    = "asia-southeast1"
  delete_contents_on_destroy = true  

}

resource "google_bigquery_dataset" "marts_dataset" {
  dataset_id                  = var.marts_dataset_id
  location                    = "asia-southeast1"
  delete_contents_on_destroy = true  
}

resource "google_bigquery_dataset" "raw_dataset" {
  dataset_id                  = var.raw_dataset_id
  location                    = "asia-southeast1"
  delete_contents_on_destroy = true  
}

