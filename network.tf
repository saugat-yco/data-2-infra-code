resource "google_compute_network" "default" {
  name                    = "sathi-vpc"
  auto_create_subnetworks = false
}


resource "google_compute_subnetwork" "primary_net_subnet" {
  for_each      = var.subnets
  name          = "subnet-${each.key}"
  network       = google_compute_network.default.name
  region        = each.key
  ip_cidr_range = each.value
}