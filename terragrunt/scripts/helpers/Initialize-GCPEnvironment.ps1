#Requires -Modules GoogleCloud

<#
.SYNOPSIS
Ensures target project exists and creates state bucket if it does not already exist

.DESCRIPTION
Ensures target project exists and creates state bucket if it does not already exist
#>

function Initialize-GCPEnvironment
{
	[CmdletBinding()]
	[Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSAvoidUsingWriteHost", "", Justification = "Required by design")]
	param (
		[Parameter(Mandatory = $True)]
		[String]$Project
	)

	Import-Module `
		-Name GoogleCloud `
		-Force `
		-ErrorAction Stop

	$TargetProject = Get-GcpProject `
		-Name $Project `
		-ErrorAction Stop

	if (-not $TargetProject)
	{
		throw "Project <$Project> not found"
	}

	$ExistingBucket = Get-GcsBucket `
		-Project $Project `
		-ErrorAction Stop | Where-Object { $_.Name -eq $Project }

	if ($ExistingBucket)
	{
		Write-Host "State bucket <$Project> already exists"
	}
	else
	{
		New-GcsBucket -Name $Project | Out-Null

		Write-Host "State bucket <$Project> created"
	}
}
