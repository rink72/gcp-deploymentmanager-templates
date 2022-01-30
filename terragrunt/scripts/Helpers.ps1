#region Libraries

$Libraries = @(
	"Helpers"
)

ForEach ($Path in $Libraries)
{
	Write-Host "Checking $Path folder"
	$TargetLibraries = Get-ChildItem `
		-Path (Join-Path -Path $PSScriptRoot -ChildPath $Path) `
		-Filter *.ps1 `
		-Recurse `
		-ErrorAction Stop

	Write-Host ($TargetLibraries | Out-String)

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
