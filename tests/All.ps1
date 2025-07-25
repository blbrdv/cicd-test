#Requires -Version 5.0

param (
    [Parameter(Mandatory=$true)]
    [string] $Path,
    [Parameter(Mandatory=$true)]
    [string] $Archs,
    [AllowEmptyString()]
    [string] $Version
)

Set-StrictMode -Version 3.0;
$ErrorActionPreference = "Stop";
trap { Write-Output $_; exit 1 };

function Exec-Ezstore {

    param(
        [Parameter(Mandatory=$true,Position=0)]
        [string] $Path,
        [Parameter(Mandatory=$true,Position=1)]
        [string] $Arguments
    )

    $global:LASTEXITCODE = $null;

    $Path = [IO.Path]::Combine((Get-Location).Path.Trim(), $Path.Trim()).Replace('\.','');
#     $Driver = $Path.SubString(0, 1);
#
#     if ( -Not (Test-Path "$Driver:\") ) {
#         net use X: \\NDRIVE01\Svcs_FG
#     }

    try {
        Push-Location;
        Set-Location $Path;

        $Output = Invoke-Expression -Command ".\ezstore.exe $Arguments 2>&1";

        $ExitCode = $global:LASTEXITCODE;
        $global:LASTEXITCODE = $null;

        return [string[]]($Output -split [Environment]::NewLine), [int]$ExitCode;
    } finally {
        Pop-Location;
    }

}

function Install-Module-Force {

    param(
        [Parameter(Mandatory=$true)]
        [string] $Name,
        [AllowEmptyString()]
        [string] $Version
    )

    if ( "" -eq $Version ) {
        & {
            $ProgressPreference = 'Ignore';
            Install-Module -Name $Name -SkipPublisherCheck -Force 3>$null;
        }
    } else {
        if ( $null -eq (Get-Module -ListAvailable -Name $Name | Where-object Version -ge $Version) ) {
            & {
                $ProgressPreference = 'Ignore';
                Install-Module -Name $Name -MinimumVersion $Version -SkipPublisherCheck -Force 3>$null;
            }
        }
    }


}

# See https://github.com/PowerShell/PowerShell/issues/13138#issuecomment-1820195503
function Import-Module-Adhog {

    param(
        [Parameter(Mandatory=$true)]
        [string] $Name,
        [AllowEmptyString()]
        [string] $Version
    )

    if ( "" -eq $Version ) {
        & {
            $ProgressPreference = 'Ignore';
            Import-Module -Name $Name -UseWindowsPowerShell 3>$null;
        }
    } else {
        if ( $null -eq (Get-Module -ListAvailable -Name $Name | Where-object Version -ge $Version) ) {
            & {
                $ProgressPreference = 'Ignore';
                Import-Module -Name $Name -MinimumVersion $Version -UseWindowsPowerShell 3>$null;
            }
        }
    }

}

$Targets = $Archs -split "," | ForEach-Object {
    @{
        Arch = $_
        Path = "$Path$_\bin"
    }
};

Install-Module-Force -Name "Pester" -Version "5.7.1";
Import-Module-Adhog -Name "Pester" -Version "5.7.1";

# For some reason default glob search in New-PesterContainer Path parameter didn't work for me so using Get-ChildItem
$Containers = Get-ChildItem -Path $PSScriptRoot -Filter "*.Tests.ps1" -ErrorAction 'SilentlyContinue'
    | ForEach-Object {
        New-PesterContainer -Path $_;
    };

Invoke-Pester -Container $Containers -Output Detailed;
