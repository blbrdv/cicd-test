function Install {

    param(
        [Parameter(Mandatory=$true,Position=0)]
        [string] $Path,
        [Parameter(Mandatory=$true,Position=1)]
        [string] $Id,
        [Parameter(Mandatory=$true,Position=2)]
        [string] $Version
    )

    return Exec-Ezstore $Path "install $Id --version $Version --verbosity d";
}
