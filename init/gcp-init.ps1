#Requires -Modules GoogleCloud

[CmdletBinding()]
param (
	[Parameter()]
	[String]$BucketName = "rink72-lab-infra-2"
)

$ErrorActionPreference = "Stop"

Import-Module `
	-Name GoogleCloud `
	-Force

$ExistingBucket = Get-GcsBucket | Where-Object { $_.Name -eq $BucketName }

if ($ExistingBucket)
{
	Write-Host "State bucket <$BucketName> already exists"
}
else
{
	New-GcsBucket `
		-Name $BucketName | Out-Null

	Write-Host "State bucket <$BucketName> created"
}

