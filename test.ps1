Set-StrictMode -Version 3.0;
$ErrorActionPreference = "Stop";
trap { Write-Error $_ -ErrorAction Continue; exit 1 };

.\ezstore.exe install 9mvsm3j7zj7c --ver v1.1.0.0 --verbosity d

Get-ChildItem HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall
    | foreach-object {Get-ItemProperty $_.PsPath}
    | %{$_.Displayname}
    | echo
