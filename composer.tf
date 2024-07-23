resource "google_project_service" "composer_api" {
  provider           = google
  project            = "Data 2 - NP"
  service            = "composer.googleapis.com"
  disable_on_destroy = false
}

resource "google_composer_environment" "composer_environment_dev" {
  provider = google
  name     = "composer-environment-dev"

  config {

    software_config {
      image_version = "composer-2.8.5-airflow-2.7.3"
    }

    node_config {
      service_account = google_service_account.custom_service_account.email
    }

  }
}