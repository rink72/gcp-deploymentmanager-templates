<#
.SYNOPSIS
Sets required terraform environment variables

.DESCRIPTION
Sets required terraform environment variables
#>

function Set-TerraformEnvironment
{
	[CmdletBinding()]
	[Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSAvoidUsingWriteHost", "", Justification = "Required by design")]
	param ()

	{
		# Set env var to tell Terraform it's running in automation pipeline
		$env:TF_IN_AUTOMATION = "true"

		# Create a low-level folder for the TG cache 
		# so that we don"t run in to errors with long files names
		# This only affects windows
		if ($IsWindows)
		{
			$TGCachePath = "c:\tgcache"
			$null = New-Item `
				-Path $TGCachePath `
				-ItemType Directory `
				-Force

			$env:TERRAGRUNT_DOWNLOAD = $TGCachePath
		}
	}
}
