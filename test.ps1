Set-StrictMode -Version 3.0;
$ErrorActionPreference = "Stop";
trap { Write-Error $_ -ErrorAction Continue; exit 1 };

.\ezstore.exe install $ID --ver $Version --verbosity d

Get-ChildItem HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall
    | foreach-object {Get-ItemProperty $_.PsPath}
    | %{$_.Displayname}
    | echo
