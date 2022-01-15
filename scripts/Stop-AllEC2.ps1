# This function will shutdown all EC2 instances in the current account

Import-Module AWSPowerShell.NetCore

$allRegions = Get-EC2Region

foreach ($region in $allRegions) {
    Write-Host "Stopping EC2 Instances in $($region.RegionName)"
    $ec2Instances = Get-EC2Instance -Region $region.RegionName
    $ec2Instances | Stop-EC2Instance -Enforce $true
}