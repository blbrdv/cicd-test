Set-StrictMode -Version 3.0;
$ErrorActionPreference = "Stop";
trap { Write-Error $_ -ErrorAction Continue; exit 1 };

$Id = "f1o2o3b4a5r6";
$Expected = '^\[ERR\] Finished with error: can not fetch product info: product with id "' $Id '" and locale "en-US" not found$';

Write-Host "";
$Actual = .\bin\ezstore.exe install $Id --verbosity m 2>&1;
Write-Host $Actual;
$Actual = $Actual -replace '\x1b\[[0-9;]*m';

Write-Host "";
if ( $Actual -match $Expected ) {
    Write-Host "Test passed!";
    exit 0;
}

Write-Host "Expected (regexp): '$Expected'";
throw 'Incorrect app output.';
