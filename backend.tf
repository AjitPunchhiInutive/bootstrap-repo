terraform {
  backend "gcs" {
    bucket = "itp-terraform-test"
    prefix = "gcp-bootstrap/state"
    impersonate_service_account = "github-actions@melodic-furnace-403022.iam.gserviceaccount.com"
  }
}
