function Run {
    $Result = & tree -L 2 .\test 2>&1;

    if ( $LastExitCode -ne 0 ) {
        throw "App exit with code ${LastExitCode}";
    }

    return $Result.Split("\n");
}