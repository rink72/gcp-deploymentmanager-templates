#Requires -Modules GoogleCloud

[CmdletBinding()]
[Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSAvoidUsingWriteHost", "", Justification = "Required by design")]
param (
	[String]$Project
)

$ErrorActionPreference = "Stop"

Import-Module `
	-Name GoogleCloud `
	-Force

$TargetProject = Get-GcpProject -Name $Project

if (-not $TargetProject)
{
	throw "Project <$Project> not found"
}

$ExistingBucket = Get-GcsBucket | Where-Object { $_.Name -eq $Project }

if ($ExistingBucket)
{
	Write-Host "State bucket <$ProjectName> already exists"
}
else
{
	New-GcsBucket -Name $Project | Out-Null

	Write-Host "State bucket <$ProjectName> created"
}
