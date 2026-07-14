# terraform-workspace

This folder contains the environment-specific Terraform configuration that consumes the reusable module(s) in `terraform-module/`.

Purpose

- Provide top-level infrastructure wiring and environment-specific variable files (`dev.tfvars`, `qa.tfvars`, `prod.tfvars`).
- Keep environment-specific templates and overrides (e.g., `userdata.tpl`, `ec2-vpc.yaml`).

Repository layout (this folder)

- `main.tf` — top-level configuration that calls the module(s).
- `providers.tf` — provider configuration for this workspace.
- `variables.tf` / `output.tf` — workspace inputs and outputs.
- `dev.tfvars`, `qa.tfvars`, `prod.tfvars` — environment variable files.
- `userdata.tpl`, `ec2-vpc.yaml` — environment templates.
- `module/` — local copies or overrides of nested module pieces (e.g., `vpc/`, `security/`).

Prerequisites

- Terraform >= 1.0 installed and on PATH.
- AWS credentials (or other provider creds) available via environment, shared config, or a secrets manager.

Quick start

From this folder run:

```bash
terraform init
terraform workspace select dev || terraform workspace new dev
terraform plan -var-file=dev.tfvars
terraform apply -var-file=dev.tfvars
```

To target another environment, replace `dev.tfvars` with `qa.tfvars` or `prod.tfvars`.

Using the module

This workspace expects to call the module located at `../terraform-module` (relative). Example `module` block:

```hcl
module "ec2_vpc" {
  source = "../terraform-module"
  # supply required variables here or via tfvars
}
```

Variables and secrets

- Inspect `variables.tf` to see required inputs. Keep sensitive values out of committed `*.tfvars` files.
- Use environment variables, an external secrets manager, or a Terraform Cloud/Enterprise workspace variable set for secrets.

Notes and recommendations

- Keep `dev.tfvars` small and non-sensitive for local testing; do not commit secrets for prod.
- If you need to customize `userdata.tpl` per environment, copy it here and reference the local file.
- Consider adding a CI job that runs `terraform validate` and `terraform plan` for PRs.

Troubleshooting

- If `terraform plan` fails, run `terraform init -upgrade` then re-run the plan.
- Confirm provider credentials and region settings in `providers.tf` or environment variables.

Contact

When requesting help, include the workspace name, the `tfvars` you used, and a redacted plan output.
