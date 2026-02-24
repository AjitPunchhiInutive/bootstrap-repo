environment     = "dev"
environment_key = "d"
bucket_name     = "sw-iac-tfstate"
gcp_project     = "sw-iac-core"
region          = "us"
zone            = "us-east4-a"
organization_id = "728935495814"
owner           = "southwire"

default_labels = {
  cost-center = "xxxx"
  provisioner = "terraform"
  sensitivity = "restricted"
}
