variable "subnets" {
  type = map(any)
  default = {
    australia-southeast1 = "10.0.2.0/24"
    asia-east1           = "10.0.3.0/24"
    europe-west4         = "10.0.4.0/24"
  }
}