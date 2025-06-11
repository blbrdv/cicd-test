Set-StrictMode -Version 3.0;
$ErrorActionPreference = "Stop";
trap { Write-Error $_ -ErrorAction Continue; exit 1 };

###### IMPORT

. ".\install.ps1"
. ".\app.ps1"

###### UTILS

function Compare-Output {
    Param (
        [Parameter(Mandatory=$true,Position=0)]
        [string[]]$Expected,
        [Parameter(Mandatory=$true,Position=1)]
        [string[]]$Actual
    )

    if ( ($null -eq $Actual) -or ($null -eq $Expected) ) {
        throw "Invalid argument";
    }

    if ( $Actual.Length -ne $Expected.Length ) {
        throw "Lengths of arrays must be equal. Expected ${$Expected.Length}, actual ${$Actual.Length}";
    }

    for ( $i = 0; $i -lt $Actual.Length; $i++ ) {
        $Left = $Actual[$i];
        $Right = $Expected[$i];

        if ( $Left -notmatch $Right ) {
            throw "Lines does not match.`n" +
                    "Expected:`n" +
                    "  $Right`n" +
                    "Actual:`n" +
                    "  $Left`n";
        }
    }
}

###### DATA

$ID = "9mvsm3j7zj7c";
$Name = "PeterEtelej.TreeCLI"
$Version = "v1.1.0.0";

###### TEST 1

$Expected = @(
    '^[DEB] Trace file: .:[^.]\.log$',
    '^[DEB] Temp dir: .:\Users\[^\]\AppData\Local\Temp\ezstore\' + [regex]::Escape($ID) + '$',
    '^[DEB] Fetching cookie\.\.\.$',
    '^THIS MUST FAIL$' #'^[INF] Cookie fetched$',
    '^[DEB] Fetching product info\.\.\.$',
    '^[INF] Product info fetched$',
    '^[DEB] Fetching product files\.\.\.$',
    '^[INF] Product files fetched$',
    '^[DEB] Download product files\.\.\.$',
    '^[INF] Product files downloaded$',
    '^[INF] Package ' + [regex]::Escape($Name) + ' ' + [regex]::Escape($Version) + ' installed.$',
    '^[SCC] Done!$'
);
$Actual = Install $ID $Version;

Compare-Output $Expected $Actual;

###### TEST 2

$Expected = @(
     '^Folder PATH listing for volume .*$'
     '^Volume serial number is .*$'
     '^.:.*$'
     '^No subfolders exist $'
 );
$Actual = Run;

Compare-Output $Expected $Actual;
