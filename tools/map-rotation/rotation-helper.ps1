# HeroesRogue map rotation helper.
#
# Heroes of the Storm only plays offline maps properly from 4 fixed paths. HeroesRogue keeps three
# of them fixed and uses the Try Mode path as a rotating slot. When a rotating map is chosen on the
# map choice screen (with "Extra maps" enabled in the options menu), the mod saves its name to the
# save bank ("RotationMap"); this helper watches the bank and swaps that map's folder into the
# rotating slot before the game loads it.
#
# Spare maps live in maps/heroes/singleplayermaps/rotation. While the game is closed the slot is put
# back to Sky Temple, so the maps folder always matches the HeroesRogue download and updating the
# mod by copying files over it is safe.
#
# Usage:
#   install-map-rotation.cmd / uninstall-map-rotation.cmd (start the helper at login, or remove it)
#   powershell -ExecutionPolicy Bypass -File rotation-helper.ps1 [-Game <Heroes of the Storm dir>] [-Bank <PlayerSettings.StormBank>] [-LogFile <file>]
param(
    [string]$Game,
    [string]$Bank,
    [string]$LogFile,
    [switch]$Install,
    [switch]$Uninstall
)
$ErrorActionPreference = 'Stop'

$homeMap = 'ControlPoints' # the map that ships in the rotating slot
$installDir = Join-Path $env:LOCALAPPDATA 'HeroesRogue'
$shortcutPath = Join-Path ([Environment]::GetFolderPath('Startup')) 'HeroesRogue Map Rotation.lnk'

function Log([string]$msg) {
    $line = (Get-Date).ToString('T') + '  ' + $msg
    Write-Host $line
    if ($LogFile) { Add-Content -LiteralPath $LogFile -Value $line }
}

# Install folder from the uninstall entry Battle.net writes, else the default location
function Find-Game {
    $keys = 'HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Heroes of the Storm',
            'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Heroes of the Storm'
    foreach ($key in $keys) {
        try {
            $location = (Get-ItemProperty -Path $key -ErrorAction Stop).InstallLocation
            if ($location -and (Test-Path $location)) { return $location }
        } catch { }
    }
    return 'C:\Program Files (x86)\Heroes of the Storm'
}

# The HeroesRogue save bank that was written most recently
function Find-Bank {
    $root = Join-Path ([Environment]::GetFolderPath('MyDocuments')) 'Heroes of the Storm\Accounts'
    $banks = Get-ChildItem -Path $root -Filter 'PlayerSettings.StormBank' -Recurse -ErrorAction SilentlyContinue |
        Where-Object { (Get-Content -LiteralPath $_.FullName -Raw) -match 'Heroes Rogue' } |
        Sort-Object LastWriteTime -Descending
    if ($banks) { return @($banks)[0].FullName }
    return $null
}

function Test-GameRunning {
    return [bool](Get-Process -Name 'HeroesOfTheStorm_x64', 'HeroesOfTheStorm' -ErrorAction SilentlyContinue)
}

# Map ID (e.g. "Shrines") of a map folder, read from its MapScript
function Get-MapId([string]$mapDir) {
    $script = Join-Path $mapDir 'MapScript.galaxy'
    if (-not (Test-Path -LiteralPath $script)) { return $null }
    $m = [regex]::Match((Get-Content -LiteralPath $script -Raw), 'libCore_gv_mAPMapStringID = "([^"]+)"')
    if ($m.Success) { return $m.Groups[1].Value }
    return $null
}

function Get-RequestedMap {
    try { $xml = Get-Content -LiteralPath $Bank -Raw } catch { return $null }
    $section = [regex]::Match($xml, '<Section name="Affix Data">([\s\S]*?)</Section>')
    if (-not $section.Success) { return $null }
    $m = [regex]::Match($section.Groups[1].Value, '<Key name="RotationMap">\s*<Value string="([^"]*)"')
    if ($m.Success -and $m.Groups[1].Value) { return $m.Groups[1].Value }
    return $null
}

function Get-LibraryMaps {
    $maps = @{}
    foreach ($dir in Get-ChildItem -LiteralPath $libraryDir -Directory -ErrorAction SilentlyContinue) {
        $id = Get-MapId $dir.FullName
        if ($id) { $maps[$id.ToLower()] = $dir.FullName }
    }
    return $maps
}

# Move the current slot map back into the library and the wanted one into the slot (same-drive renames).
# Returns the map now in the slot; throws if the swap can't happen yet.
function Swap-In([string]$current, [string]$wanted) {
    $source = (Get-LibraryMaps)[$wanted.ToLower()]
    if (-not $source) { throw "`"$wanted`" is not in the map library ($libraryDir)" }
    $parkedName = $(if ($current) { $current } else { 'Unknown' })
    $parked = Join-Path $libraryDir ($parkedName + '.stormmap')
    if (Test-Path -LiteralPath $parked) { throw "library already has $parked" }
    [IO.Directory]::Move($slotDir, $parked)
    try {
        [IO.Directory]::Move($source, $slotDir)
    } catch {
        [IO.Directory]::Move($parked, $slotDir) # put the old map back so the slot is never empty
        throw
    }
    Log "rotating slot: $parkedName -> $wanted"
    return $wanted
}

# Stop helpers started earlier (by the installer, at login, or by hand)
function Stop-Helpers {
    Get-CimInstance Win32_Process -Filter "Name = 'powershell.exe' OR Name = 'pwsh.exe'" |
        Where-Object { $_.ProcessId -ne $PID -and $_.CommandLine -like '*rotation-helper.ps1*' -and $_.CommandLine -notlike '*-Install*' -and $_.CommandLine -notlike '*-Uninstall*' } |
        ForEach-Object { Stop-Process -Id $_.ProcessId -Force -ErrorAction SilentlyContinue }
}

if (-not $Game) { $Game = Find-Game }
$mapsDir = Join-Path $Game 'maps\heroes\singleplayermaps'
$slotDir = Join-Path $mapsDir '(10)trymemode.stormmap'
$libraryDir = Join-Path $mapsDir 'rotation'

if ($Install) {
    if (-not (Test-Path -LiteralPath $slotDir) -or -not (Test-Path -LiteralPath $libraryDir)) {
        throw "HeroesRogue maps not found in $mapsDir. Copy the HeroesRogue maps and mods folders into the game folder first."
    }
    $probe = Join-Path $mapsDir ('rotation-write-test-' + $PID)
    try {
        [void](New-Item -ItemType Directory -Path $probe)
        Remove-Item -LiteralPath $probe
    } catch {
        throw "Can't write to $mapsDir, so maps can't be swapped. Give your user account write access to that folder and run the installer again."
    }
    Stop-Helpers
    [void](New-Item -ItemType Directory -Force -Path $installDir)
    $installed = Join-Path $installDir 'rotation-helper.ps1'
    Copy-Item -LiteralPath $PSCommandPath -Destination $installed -Force
    $log = Join-Path $installDir 'rotation.log'
    $arguments = "-NoProfile -WindowStyle Hidden -ExecutionPolicy Bypass -File `"$installed`" -LogFile `"$log`""

    $shell = New-Object -ComObject WScript.Shell
    $shortcut = $shell.CreateShortcut($shortcutPath)
    $shortcut.TargetPath = Join-Path $PSHOME 'powershell.exe'
    $shortcut.Arguments = $arguments
    $shortcut.WorkingDirectory = $installDir
    $shortcut.WindowStyle = 7 # minimized
    $shortcut.Description = 'Swaps HeroesRogue extra maps into place'
    $shortcut.Save()

    Start-Process -FilePath (Join-Path $PSHOME 'powershell.exe') -ArgumentList $arguments -WindowStyle Hidden
    Write-Host "Map rotation helper installed and running. It starts automatically when you log in."
    Write-Host "Turn on 'Extra maps' in the HeroesRogue options menu to play the extra maps."
    Write-Host "Log: $log"
    exit
}

if ($Uninstall) {
    Stop-Helpers
    Remove-Item -LiteralPath $shortcutPath -ErrorAction SilentlyContinue
    if ((Test-Path -LiteralPath $slotDir) -and -not (Test-GameRunning)) {
        $current = Get-MapId $slotDir
        if ($current -ne $homeMap) {
            try { [void](Swap-In $current $homeMap) } catch { Write-Host "Couldn't put $homeMap back in the slot: $($_.Exception.Message)" }
        }
    }
    Remove-Item -LiteralPath $installDir -Recurse -Force -ErrorAction SilentlyContinue
    Write-Host 'Map rotation helper removed.'
    exit
}

# Only one helper at a time
$mutex = New-Object Threading.Mutex($false, 'Local\HeroesRogueMapRotation')
try {
    if (-not $mutex.WaitOne(0)) { Write-Host 'Map rotation helper is already running.'; exit }
} catch [Threading.AbandonedMutexException] { } # previous helper was killed; the mutex is ours now

if ($LogFile) { Set-Content -LiteralPath $LogFile -Value $null } # fresh log each start
if (-not (Test-Path -LiteralPath $slotDir)) { throw "HeroesRogue rotating slot not found: $slotDir (use -Game)" }
$slotMap = Get-MapId $slotDir
Log "game:    $Game"
Log ("library: $libraryDir  [" + ((Get-LibraryMaps).Keys -join ', ') + ']')
Log ('slot:    ' + $(if ($slotMap) { $slotMap } else { 'empty/unknown' }))
Log 'watching... (Ctrl+C to stop)'

$requested = $null
$lastWrite = [datetime]::MinValue
$lastBankSearch = [datetime]::MinValue
$failedTarget = $null
while ($true) {
    $running = Test-GameRunning
    if (-not $Bank -and ((Get-Date) - $lastBankSearch).TotalSeconds -gt 30) {
        $lastBankSearch = Get-Date
        $Bank = Find-Bank
        if ($Bank) { Log "bank:    $Bank" }
    }
    if ($Bank) {
        try {
            $write = [IO.File]::GetLastWriteTimeUtc($Bank)
            if ($write -ne $lastWrite) {
                $lastWrite = $write
                $requested = Get-RequestedMap
            }
        } catch { } # bank being rewritten
    }

    # In game: the map the save asks for. Game closed: the map that ships in the slot.
    $target = $homeMap
    if ($running -and $requested) { $target = $requested }
    if ($slotMap -ne $target) {
        try {
            $slotMap = Swap-In $slotMap $target
            $failedTarget = $null
        } catch {
            # Usually a file in the slot is still open; keep retrying, but only log once
            if ($failedTarget -ne $target) {
                Log "can't swap in ${target} yet: $($_.Exception.Message)"
                $failedTarget = $target
            }
        }
    }
    if ($running) { Start-Sleep -Milliseconds 200 } else { Start-Sleep -Seconds 3 }
}
