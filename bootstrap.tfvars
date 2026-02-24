environment     = "dev"
environment_key = "d"
bucket_name     = "itp-terraform-tfstate"
gcp_project     = "melodic-furnace-403022"
region          = "us"
zone            = "us-east4-a"
organization_id = "203589767236"
owner           = "southwire"

default_labels = {
  cost-center = "xxxx"
  provisioner = "terraform"
  sensitivity = "restricted"
}
