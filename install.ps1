function Install {
    Param (
        [Parameter(Mandatory=$true,Position=0)]
        [string]$ID,
        [Parameter(Mandatory=$true,Position=1)]
        [string]$Version
    )

    $Result = & .\ezstore.exe install $ID --ver $Version --verbosity d 2>&1;

    if ( $LastExitCode -ne 0 ) {
        throw "ezstore exit with code ${LastExitCode}";
    }

    return $Result.Split("\n");
}