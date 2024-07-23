resource "google_storage_bucket" "tf-bucket" {
  name          = "tf-bucket"
  location      = "AU"
  force_destroy = true

  uniform_bucket_level_access = true

  website {
    main_page_suffix = "index.html"
    not_found_page   = "404.html"
  }
  cors {
    origin          = ["http://image-store.com"]
    method          = ["GET", "HEAD", "PUT", "POST", "DELETE"]
    response_header = ["*"]
    max_age_seconds = 3600
  }
}


resource "google_compute_instance" "vm-1" {
  name         = "vm-1"
  machine_type = "e2-medium"
  zone         = "australia-southeast1-a"
  project      = "Data 2 - NP"

  labels = {
    environment = "dev"
  }

  boot_disk {
    auto_delete = true

    initialize_params {
      image = "https://www.googleapis.com/compute/beta/projects/ubuntu-os-cloud/global/images/ubuntu-2004-focal-v20240110"
      size  = 20
      type  = "pd-balanced"
    }
  }


  network_interface {
    network    = google_compute_network.default.name
    subnetwork = "subnet-australia-southeast1"
    stack_type = "IPV4_ONLY"

    access_config {
      // Specify an external IP address for the instance
    }
  }

  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
    provisioning_model  = "STANDARD"
  }

  service_account {
    email  = google_service_account.custom_service_account.email
    scopes = ["https://www.googleapis.com/auth/cloud-platform", "https://www.googleapis.com/auth/devstorage.read_only", "https://www.googleapis.com/auth/logging.write", "https://www.googleapis.com/auth/monitoring.write", "https://www.googleapis.com/auth/service.management.readonly", "https://www.googleapis.com/auth/servicecontrol", "https://www.googleapis.com/auth/trace.append"]
  }

  shielded_instance_config {
    enable_integrity_monitoring = true
    enable_vtpm                 = true
  }

  tags                = ["http-server", "https-server"]
  deletion_protection = false
}