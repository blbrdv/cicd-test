function Install {
    Param (
        [Parameter(Mandatory=$true,Position=0)]
        [string]$CurrentPath,
        [Parameter(Mandatory=$true,Position=1)]
        [string]$ID,
        [Parameter(Mandatory=$true,Position=2)]
        [string]$Version
    )

    $Result = & $CurrentPath\ezstore.exe install $ID --ver $Version --verbosity d 2>&1;

    if ( $LastExitCode -ne 0 ) {
        throw "ezstore exit with code ${LastExitCode}";
    }

    $Result = $Result -replace '\x1b\[[0-9;]*m';

    return $Result.Split("\n");
}