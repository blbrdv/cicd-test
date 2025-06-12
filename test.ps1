Set-StrictMode -Version 3.0;
$ErrorActionPreference = "Stop";
trap { Write-Error $_ -ErrorAction Continue; exit 1 };

.\ezstore.exe install 9mvsm3j7zj7c --ver v1.1.0.0 --verbosity d

Write-Host "======";

Import-Module -Name Appx -UseWindowsPowerShell -WarningAction SilentlyContinue;
Get-AppxPackage;
