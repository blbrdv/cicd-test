Set-StrictMode -Version 3.0;
$ErrorActionPreference = "Stop";
trap { Write-Error $_ -ErrorAction Continue; exit 1 };

Write-Host "";
$Expected = '';
$Actual = .\bin\ezstore.exe install f1o2o3b4a5r6 --verbosity m 2>&1;
$Actual = $Actual -replace '\x1b\[[0-9;]*m';

Write-Host "";
if ( $Actual -match $Expected ) {
    Write-Host "Test passed!";
    exit 0;
}

Write-Host: "Expected: '$Expected'";
Write-Host: "Actual:";
Write-Host: $Actual;
throw 'Incorrect app output.';
