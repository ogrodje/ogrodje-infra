terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.5.0"
    }
  }
}

provider "google" {
  credentials = file("ogrodje-gcp-credentials.json")
  project = "ogrodje"
  region = "us-central1"
  zone   = "us-central1-c"
}

resource "google_storage_bucket" "archive" {
  name          = "ogrodje-archive"
  location      = "EUROPE-WEST3"
  force_destroy = true
}

resource "google_storage_bucket_object" "archive_raw_folder" {
  name          = "raw-recordings/"
  content       = "Folder for raw recordings"
  bucket        = "${google_storage_bucket.archive.name}"
}

resource "google_storage_bucket_object" "archive_final_folder" {
  name          = "final-recordings/"
  content       = "Folder for raw recordings"
  bucket        = "${google_storage_bucket.archive.name}"
}

resource "google_storage_bucket_iam_member" "oto_viewer" {
  bucket = google_storage_bucket.archive.id
  role = "roles/storage.objectViewer"
  member = "user:${var.oto_test_email}"
}

resource "google_storage_bucket_iam_member" "oto_creator" {
  bucket = google_storage_bucket.archive.id
  role = "roles/storage.objectCreator"
  member = "user:${var.oto_test_email}"
}
