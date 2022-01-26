#Requires -Modules GoogleCloud

[CmdletBinding()]
[Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSAvoidUsingWriteHost", "", Justification = "Required by design")]
param ()

$ErrorActionPreference = "Stop"

Import-Module `
	-Name GoogleCloud `
	-Force

# We are coding this to work in ACloudGuru playground environments
$ProjectName = (Get-GcpProject | Where-Object { $_.Name -like "playground*" }).Name

if ($ProjectName.count -gt 1)
{
	throw "More than one possible project found. $ProjectName"
}

$ExistingBucket = Get-GcsBucket | Where-Object { $_.Name -eq $ProjectName }

if ($ExistingBucket)
{
	Write-Host "State bucket <$ProjectName> already exists"
}
else
{
	New-GcsBucket `
		-Name $ProjectName | Out-Null

	Write-Host "State bucket <$ProjectName> created"
}

$env:GCP_TF_STATE_BUCKET = $ProjectName
$env:GCP_TF_PROJECT = $ProjectName
