function Test {
    Param (
        [Parameter(Mandatory=$true,Position=0)]
        [string[]]$Actual,
        [Parameter(Mandatory=$true,Position=1)]
        [string[]]$Expected
    )

    if ( ($null -eq $Actual) -or ($null -eq $Expected) ) {
        throw "Invalid argument";
    }

    if ( $Actual.Length -ne $Expected.Length ) {
        throw "Lengths of arrays must be equal";
    }

    for ( $i = 0; $i -lt $Actual.Length; $i++ ) {
        $Left = $Actual[i];
        $Right = $Expected[i];

        if ( $Left -notmatch $Right ) {
            throw "Lines does not match.`n" +
                    "Expected:`n" +
                    "  $Right`n" +
                    "Actual:`n" +
                    "  $Left`n";
        }
    }
}