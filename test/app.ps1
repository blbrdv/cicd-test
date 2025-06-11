function Run {
    $Result = & tree ".\test" 2>&1;

    if ( $LastExitCode -ne 0 ) {
        throw "App exit with code ${LastExitCode}";
    }

    if ( ($null -eq $Result) -or ($Result -eq "") ) {
        return @();
    }

    return $Result.Split("\n");
}