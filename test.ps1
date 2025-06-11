Set-StrictMode -Version 3.0;
$ErrorActionPreference = "Stop";
trap { Write-Error $_ -ErrorAction Continue; exit 1 }

$ID = "9mvsm3j7zj7c";
$Name = "PeterEtelej.TreeCLI"
$Version = "v1.1.0.0";

$InstallResult = Install $ID $Version;

Test
    @(
        '[DEB] Trace file: .:[^.]\.log',
        '[DEB] Temp dir: .:\Users\[^\]\AppData\Local\Temp\ezstore\' + [regex]::Escape($ID),
        '[DEB] Fetching cookie\.\.\.',
        '[INF] Cookie fetched',
        '[DEB] Fetching product info\.\.\.',
        '[INF] Product info fetched',
        '[DEB] Fetching product files\.\.\.',
        '[INF] Product files fetched',
        '[DEB] Download product files\.\.\.',
        '[INF] Product files downloaded',
        '[INF] Package ' + [regex]::Escape($Name) + ' ' + [regex]::Escape($Version) + ' installed.',
        '[SCC] Done!'
    ), $InstallResult;

$AppResult = App;

Test
    @(
        'Folder PATH listing for volume .*'
        'Volume serial number is .*'
        '.:.*'
        'No subfolders exist '
    ), $AppResult;
