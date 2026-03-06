terraform {
  backend "gcs" {
    bucket = "itp-terraform-test"
    prefix = "gcp-bootstrap-itp-test/state"
  }
}
