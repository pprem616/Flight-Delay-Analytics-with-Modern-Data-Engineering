variable "project_id" {
  description = "Google Cloud project ID"
  type        = string
}
variable "secret_key" {
  type        = string
}

variable "region" {
  description = "Bucket location"
  type        = string
  default     = "ASIA"
}

variable "bucket_name" {
  description = "Name of the GCS bucket"
  type        = string
}

variable "stg_dataset_id" {
  description = "dataset to store stg table"
  type        = string
}

variable "marts_dataset_id" {
  description = "dataset to store marts table"
  type        = string
}

variable "raw_dataset_id" {
  description = "store source and seed"
  type        = string
}