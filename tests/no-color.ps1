Set-StrictMode -Version 3.0;
$ErrorActionPreference = "Stop";
trap { Write-Error $_ -ErrorAction Continue; exit 1 };

$Id = "9mvsm3j7zj7c";
$Name = "PeterEtelej.TreeCLI";
$Version = "1.1.0.0";

Write-Host "";
$Env:NO_COLOR = "1"
$Output = .\bin\ezstore.exe install $Id --ver $Version --verbosity m 2>&1;

Write-Host "";
if ( $Output -match '\x1b\[[0-9;]*m' ) {
    Write-Host: "Output:";
    Write-Host: $Output;
    throw 'Output has colors.';
}

Write-Host "Test passed!";

