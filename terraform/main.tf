terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.51.0"
    }
  }
}

provider "google" {
  credentials = file("../service-account/service-account.json")

  project = "final-project-test-393302"
  region  = "asia-southeast2"
}

resource "google_storage_bucket" "data-lake-bucket" {
  name     = "final-project-lake"
  location = "asia-southeast2"

  # Optional, but recommended settings:
  storage_class               = "STANDARD"
  uniform_bucket_level_access = true

  versioning {
    enabled = true
  }

  lifecycle_rule {
    action {
      type = "Delete"
    }
    condition {
      age = 30 // days
    }
  }

  force_destroy = true
}

resource "google_bigquery_dataset" "warehouse-dataset" {
  dataset_id = "onlinetransaction_wh"
  project    = "final-project-test-393302"
  location   = "asia-southeast2"
}

resource "google_bigquery_dataset" "stream-dataset" {
  dataset_id = "onlinetransaction_stream"
  project    = "final-project-test-393302"
  location   = "asia-southeast2"
}