#region Libraries

$Libraries = @(
	"helpers"
)

ForEach ($Path in $Libraries)
{
	$TargetLibraries = Get-ChildItem `
		-Path (Join-Path -Path $PSScriptRoot -ChildPath $Path) `
		-Filter *.ps1 `
		-Recurse `
		-ErrorAction Stop

	ForEach ($Library in $TargetLibraries)
	{
		try
		{
			Write-Verbose "Importing <$($Library.FullName)>"

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
