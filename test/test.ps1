Set-StrictMode -Version 3.0;
$ErrorActionPreference = "Stop";
trap { Write-Error $_ -ErrorAction Continue; exit 1 };

###### IMPORT

. ".\test\install.ps1"
. ".\test\app.ps1"

###### UTILS

function Compare-Output {
    Param (
        [Parameter(Mandatory=$true,Position=0)]
        [AllowEmptyString()]
        [string[]]$Expected,
        [Parameter(Mandatory=$true,Position=1)]
        [AllowEmptyString()]
        [string[]]$Actual
    )

    if ( ($null -eq $Actual) -or ($null -eq $Expected) ) {
        throw "Invalid argument";
    }

    if ( $Actual.Count -ne $Expected.Count ) {
        Write-Host "Actual output:";
        for ( $i = 0; $i -lt $Actual.Count; $i++ ) {
            Write-Host "$($i + 1): $($Actual[$i])";
        }
        throw "Lengths of arrays must be equal. Expected $($Expected.Count), actual $($Actual.Count)";
    }

    for ( $i = 0; $i -lt $Actual.Count; $i++ ) {
        Write-Host "Line #$($i + 1)";
        Write-Host "Expected: $($Expected[$i])";
        Write-Host "Actual:   $($Actual[$i])";

        if ( $Actual[$i] -notmatch $Expected[$i] ) {
            throw "Lines does not match.";
        }
    }
}

###### DATA

$ID = "9mvsm3j7zj7c";
$Name = "PeterEtelej.TreeCLI"
$Version = "v1.1.0.0";

###### TEST 1

Write-Host;
Write-Host "====== TEST 1 ======";
Write-Host;

$Expected = @(
    '^\[DEB\] Trace file: .*\.log$',
    "^\[DEB\] Temp dir: .:\\Users\\.*\\AppData\\Local\\Temp\\ezstore\\$([regex]::Escape($ID))$",
    '^\[DEB\] Fetching cookie\.\.\.$',
    '^\[INF\] Cookie fetched$',
    '^\[DEB\] Fetching product info\.\.\.$',
    '^\[INF\] Product info fetched$',
    '^\[DEB\] Fetching product files\.\.\.$',
    '^\[INF\] Product files fetched$',
    '^\[DEB\] Download product files\.\.\.$',
    '^\[INF\] Product files downloaded$',
    "^\[INF\] Package $([regex]::Escape($Name)) $([regex]::Escape($Version)) installed.$",
    '^\[SCC\] Done!$'
);
$Actual = Install $ID $Version;

Compare-Output $Expected $Actual;

###### TEST 2

Write-Host;
Write-Host "====== TEST 2 ======";
Write-Host;

$Expected = @(
     '^Folder PATH listing for volume .*$',
     '^Volume serial number is .*$',
     '^.*$',
     '^No subfolders exist $',
     ''
 );
$Actual = Run;

Write-Host "Actual: $Actual";

Compare-Output $Expected $Actual;
