[CmdletBinding()]
[Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSAvoidUsingWriteHost", "", Justification = "Required by design")]
param (
	[Parameter(Mandatory = $False)]
	[String]$Project = "labrink72",

	[Parameter(Mandatory = $False)]
	[String]$Service = $env:SERVICE,

	[Parameter(Mandatory = $False)]
	[Switch]$Apply
)

try
{
	# Import helper scripts. We should eventually move all this code to a
	# PowerShell module
	. "$PSScriptRoot/Helpers.ps1"

	Initialize-GCPEnvironment -Project $Project

	Set-TerraformEnvironment

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
