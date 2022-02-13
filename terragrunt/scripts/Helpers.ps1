#region Libraries

$Libraries = @(
	"helpers"
)

Write-Host "Running helpers.ps1"

ForEach ($Path in $Libraries)
{
	$TargetLibraries = Get-ChildItem `
		-Path (Join-Path -Path $PSScriptRoot -ChildPath $Path) `
		-Filter *.ps1 `
		-Recurse `
		-ErrorAction Stop

	Write-Host $TargetLibraries

	ForEach ($Library in $TargetLibraries)
	{
		try
		{
			Write-Host "Importing <$($Library.FullName)>"

			Import-Module `
				-Name $Library.FullName `
				-Force `
				-ErrorAction Stop
		}
		catch
		{
			throw "Unable to import <$($Library.FullName)>. $_"
		}
	}
}

#endregion
