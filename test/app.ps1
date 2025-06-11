function Run {
    Param (
        [Parameter(Mandatory=$true,Position=0)]
        [string]$CurrentPath
    )

    $Result = & $CurrentPath\tree -L 2 $CurrentPath\test 2>&1;

    if ( $LastExitCode -ne 0 ) {
        throw "App exit with code ${LastExitCode}";
    }

    return $Result.Split("\n");
}