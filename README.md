
## Overview

The bootstrap layer sets up the GCP organization-level primitives required before any workload infrastructure is deployed. This includes:

---



---

## Prerequisites

- **Terraform** >= 1.6.3
- **GCP Project** with billing enabled
- **GCS Bucket** for remote state storage
- **Service Account** with permission to impersonate for state backend access (see `backend.tf`)
- SSH access to the private Terraform modules repository (`-sw-prod-udp-rds-infra-modules`)

---

## Configuration

### Variables (`RepoName.tfvars`)

| Variable          | Description                                      | Example                      |
|-------------------|--------------------------------------------------|------------------------------|
| `bucket_name`     | GCS bucket for Terraform remote state            | `Bucket_name`         |
| `gcp_project`     | GCP project ID to deploy resources into          | `Automation Project ID`     |
| `region`          | GCP region                                       | `us`                         |
| `zone`            | GCP zone                                         | `us-east4-a`                 |
| `organization_id` | GCP organization ID                              | `Organization-ID`               |

### WIF Configuration (`config/wif/*.yaml`)

Each YAML file under `config/wif/` defines one Workload Identity Federation setup. Key fields:

| Field                   | Description                                              |
|-------------------------|----------------------------------------------------------|
| `deploy`                | Set to `true` to enable this WIF configuration           |
| `pool_id`               | WIF pool ID                                              |
| `provider_id`           | WIF provider ID                                          |
| `project_id`            | GCP project to create the WIF pool and provider in       |
| `repository_owner`      | GitHub organization/user owning the repositories         |
| `sa_account_id`         | Service account ID to create for GitHub Actions          |
| `project_roles`         | IAM roles granted to the SA at the project level         |
| `org_roles`             | IAM roles granted to the SA at the organization level    |
| `sa_mapping`            | Maps GitHub repositories to the WIF SA                   |

### Folder Configuration (`config/folders/folders.yaml`)

Controls GCP folder creation under the organization. Set `deploy: true` to enable folder provisioning.

---

## Usage

### 1. Initialize Terraform

```bash
terraform init
```

### 2. Review the Plan

```bash
terraform plan -var-file="bootstrap.tfvars"
```

### 3. Apply

```bash
terraform apply -var-file="bootstrap.tfvars"
```

---

## Remote State

State is stored in GCS using the configuration in [backend.tf](backend.tf):

- **Bucket:** `itp-terraform-test`
- **Prefix:** `gcp-bootstrap/state`
- **Impersonation SA:** `github-actions@melodic-furnace-403022.iam.gserviceaccount.com`

---

## Modules

This repository sources modules from the private GitHub repository:

```
git@github.com:AjitPunchhiInutive/-sw-prod-udp-rds-infra-modules.git
```

| Module         | Path in source repo | Purpose                              |
|----------------|---------------------|--------------------------------------|
| `wif_factory`  | `//wif-factory`     | Creates WIF pools, providers, and SAs |
| `folders`      | `//folders`         | Creates GCP folder hierarchy          |

---

## Providers

| Provider       | Version Constraint          |
|----------------|-----------------------------|
| `google`       | `>= 5.20.0, <= 7.15.0`      |
| `google-beta`  | `>= 5.20.0, <= 7.15.0`      |

---

## Contributing

1. Create a feature branch from `main`.
2. Make changes and validate with `terraform plan`.
3. Open a pull request — GitHub Actions will run plan checks automatically via the WIF-enabled SA.
