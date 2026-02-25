# variable "environment" {
#   description = "Environment name (e.g. dev, staging, prod)"
#   type        = string
# }

# variable "environment_key" {
#   description = "Short environment key used in naming (e.g. d, s, p)"
#   type        = string
# }

variable "bucket_name" {
  description = "GCS bucket name for Terraform remote state"
  type        = string
}

variable "gcp_project" {
  description = "GCP project ID to deploy resources into"
  type        = string
}

variable "region" {
  description = "GCP region for resource deployment"
  type        = string
}

variable "zone" {
  description = "GCP zone for resource deployment"
  type        = string
}

variable "organization_id" {
  description = "GCP organization ID"
  type        = string
}

# variable "owner" {
#   description = "Owner identifier applied as a default label"
#   type        = string
# }

# variable "default_labels" {
#   description = "Default labels applied to all resources (cost-center, provisioner, sensitivity)"
#   type        = map(string)
#   default = {
#     cost-center = "xxxx"
#     provisioner = "terraform"
#     sensitivity = "restricted"
#   }
# }