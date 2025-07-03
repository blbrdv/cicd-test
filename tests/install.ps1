param (
    [Parameter(Mandatory=$true,Position=0)]
    [hashtable]$Target
)

Set-StrictMode -Version 3.0;
$ErrorActionPreference = "Stop";
trap { Write-Error $_ -ErrorAction Continue; exit 1 };

. ".\tests\_core.ps1";

Install $Target.Id $Target.Version;

Import-Module -Name Appx -UseWindowsPowerShell -WarningAction SilentlyContinue;

$Package = Get-AppxPackage -Name $Target.Name;

if ( $null -eq $Package ) {
    throw "Package $($Target.Name) not installed";
}

if ( $Package.Version -ne $Target.Version ) {
    throw "Wrong version installed. Expected $($Target.Version), actual: $($Package.Version)."
}

Write-Output "Test passed!";
