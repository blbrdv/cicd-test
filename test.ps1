Set-StrictMode -Version 3.0;
$ErrorActionPreference = "Stop";
trap { Write-Error $_ -ErrorAction Continue; exit 1 };

.\ezstore.exe install 9mvsm3j7zj7c --ver v1.1.0.0 --verbosity d

Write-Host "======";

$U = @(
    'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*',
    'HKLM:\SOFTWARE\Wow6432node\Microsoft\Windows\CurrentVersion\Uninstall\*',
    'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*',
    'HKCU:\SOFTWARE\Wow6432node\Microsoft\Windows\CurrentVersion\Uninstall\*'
);

foreach ($UKey in $U) {
    foreach ($Product in (Get-ItemProperty $UKey -ErrorAction SilentlyContinue)) {
        $Product | Format-Table -AutoSize;
    }
};
