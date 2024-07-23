#GCP Provider

# terraform {
#   backend "gcs" {
#     bucket = "tf-bucket"
#   }
# }

provider "google" {
  project = "Data 2 - NP"
  region  = "australia-southeast1"
}

resource "google_service_account" "custom_service_account" {
  provider     = google
  account_id   = "custom-service-account"
  display_name = "Custom Service Account"
}

resource "google_project_iam_member" "custom_service_account" {
  provider = google
  project  = "Data 2 - NP"
  member   = format("serviceAccount:%s", google_service_account.custom_service_account.email)
  // Role for Public IP environments
  role = "roles/composer.worker"
}