terraform {
  backend "gcs" {
    bucket = "itp-terraform-tfstate"
    prefix = "gcp-bootstrap/state"
  }
}
