function Run {

    $Result = & tree test 2>&1;

    if ( $LastExitCode -ne 0 ) {
        throw "app exit with code ${LastExitCode}";
    }

    return $Result.Split("\n");
}