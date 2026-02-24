locals {
  default_cost_center = lookup(var.default_labels, "cost-center", "xxxx")

  all_labels = merge(var.default_labels, {
    lifecycle = var.environment
    owner     = var.owner
  })

  template_vars = {
    environment_key     = var.environment_key
    lifecycle           = var.environment
    default_cost_center = local.default_cost_center
  }

  # WIF: list from config/wif/*.yaml
  wif_config_files = fileset("config/wif", "*.yaml")
  wif_objects = [for f in local.wif_config_files : yamldecode(templatefile("config/wif/${f}", local.template_vars))]

  # # Folders: single object from config/folders.yaml (module expects only organization_id, parent_folders, sub_folders)
  # folder_config_files = fileset("config/folders", "*.yaml")
  # folders_raw         = length(local.folder_config_files) > 0 ? yamldecode(templatefile("config/folders/folders.yaml", local.template_vars)) : null
  # folders_objects     = local.folders_raw != null ? { organization_id = local.folders_raw.organization_id, parent_folders = local.folders_raw.parent_folders, sub_folders = local.folders_raw.sub_folders } : { organization_id = var.organization_id, parent_folders = {}, sub_folders = {} }

}

module "wif_factory" {
  source                         = "git@github.com:southwire-company/gcp-shared-terraform-modules.git//wif-factory?ref=main"
  github_workload_identity_factory = local.wif_objects
}

  # module "folders" {
  # source          = "git@github.com:southwire-company/gcp-shared-terraform-modules.git//folders?ref=main"
  # folders_objects = local.folders_objects
# }
