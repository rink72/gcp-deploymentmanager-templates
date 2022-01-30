# This script takes parameters used to build the filepath to start a terragrunt deployment.
# It is required that this script be at the root of the Terragrunt parameters folder.
# It is designed to be run in ADO with parameter values set by variables

# NOTE: Due to the way Powershell and ADO handles stderr/redirection, this task
# needs to be run in ErrorActionPreference = "Continue" and then we check
# $LASTEXITCODE on operations to make sure there's no failure.

[CmdletBinding()]
[Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSAvoidUsingWriteHost", "", Justification = "Required by design")]
param (
	[String]$Project = "labrink72",

	[String]$Service = $env:SERVICE,

	[Switch]$Apply
)

try
{
	# Ensure environment is initialised
	. "$PSScriptRoot/helpers/Initialise-GCPEnvironment.ps1" -Project $Project

	# Set env var to tell Terraform it's running in automation pipeline
	$env:TF_IN_AUTOMATION = "true"

	# Create a low-level folder for the TG cache so that we don"t run in to errors with long files names
	$TGCachePath = "c:\tgcache"
	$null = New-Item `
		-Path $TGCachePath `
		-ItemType Directory `
		-Force

	$env:TERRAGRUNT_DOWNLOAD = $TGCachePath

	$CurrentPath = $PSScriptRoot

	# Build path for terragrunt config file
	$TerragruntPath = Join-Path `
		-Path $PSScriptRoot `
		-ChildPath "..\gcp" `
		-AdditionalChildPath @($Project, $Service)

	Write-Host "Setting location to $TerragruntPath"
	$null = Set-Location -Path $TerragruntPath

	Write-Host "Running terragrunt init"
	& terragrunt init --terragrunt-source-update

	Write-Host "Running terragrunt plan"
	& terragrunt plan -out=tfplan -input=false

	if ($LASTEXITCODE -ne 0)
	{
		throw "Terragrunt plan failed."
	}

	if ($Apply)
	{
		Write-Host "Running terragrunt apply"

		& terragrunt apply -auto-approve -input=false tfplan
		if ($LASTEXITCODE -ne 0)
		{
			throw "Terragrunt apply failed."
		}
	}
}
catch
{
	throw $_
}
finally
{
	if ($CurrentPath)
	{
		Set-Location -Path $CurrentPath | Out-Null
	}
}
