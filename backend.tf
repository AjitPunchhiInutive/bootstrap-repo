terraform {
  backend "gcs" {
    bucket = "sw-iac-tfstate"
    prefix = "gcp-bootstrap/state"
  }
}
