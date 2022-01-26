# GCP manual deployment

## Prerequisites

- The Google SDK must be installed. This can be downloaded from [here](https://cloud.google.com/sdk/docs/install)
- The Google Cloud Powershell module must be installed. Documentation on this can be found [here](https://cloud.google.com/tools/powershell/docs/quickstart)

## Connect to GCP

- Connect to GCP using `gcloud auth application-default login`. This will allow Terraform access to your project.
- Connect to GCP using `gcloud auth login`. This will allow Powershell access to your project.
- Run `gcloud init` to set default project

## Deploy

Once authenticated, you can now deploy a service using `Deploy-GCPTerragruntConfig.ps1`. This can take the following parameters:

- *Service*: The name of the service being deployed. This references a folder name under the `<repo root>/terragrunt/gcp/`
- *Apply*: If this switch is set, then the configuration is deployed. Otherwise only a plan is run.

```powershell
# Show terraform plan
.\Deploy-GCPTerragruntConfig.ps1 `
	-Service labbox

# Apply terraform configuration
.\Deploy-GCPTerragruntConfig.ps1 `
	-Service labbox `
	-Apply
```

## Notes

- When `Deploy-GCPTerragruntConfig.ps1` is run, it will also check for the existence of the state bucket and create it if required.
- Because this has been designed for use with acloud.guru's playground environments, it is currently hardcoded to look for that naming convention.
- The state bucket will be named identically to the project. This ensures a unique state bucket name if environments are being reprovisioned often
