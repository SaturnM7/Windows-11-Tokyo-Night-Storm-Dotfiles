# ===== WINFETCH CONFIGURATION =====

# Farbdefinitionen für reines Weiß
$white = "$([char]27)[97m"
$reset = "$([char]27)[0m"

# Pfad zu Ihrem Bild (beibehalten)
$image = "C:\Path\to\your\image"

# Den standardmäßigen Winfetch-Trenner komplett deaktivieren
$global:separator = ""

# --- DYNAMISCHER DATEN-FETCH (LIVE BEI JEDEM START) ---
$sys_user   = "$env:USERNAME@$env:COMPUTERNAME"

# Uptime berechnen
$osUptime   = (Get-CimInstance Win32_OperatingSystem).LastBootUpTime
$uptimeSpan = (Get-Date) - $osUptime
$sys_uptime = "{0} h {1} m" -f [math]::Floor($uptimeSpan.TotalHours), $uptimeSpan.Minutes

# OS & Kernel auslesen
$osInfo     = Get-CimInstance Win32_OperatingSystem
$sys_os     = $osInfo.Caption
$sys_kernel = $osInfo.Version

# Auflösung ermitteln

# Terminal und Shell
$sys_term   = if ($env:WT_SESSION) { "Windows Terminal" } else { "Host" }
$sys_shell  = "PowerShell v$($PSVersionTable.PSVersion.ToString())"

# Pakete (Scoop zählen)
$scoopPath  = "$env:USERPROFILE\scoop\apps"
$sys_pkgs   = if (Test-Path $scoopPath) { "$((Get-ChildItem $scoopPath).Count) (scoop)" } else { "0 (scoop)" }

# CPU Name (Als statischer Custom-Value beibehalten)
$sys_cpu    = (Get-CimInstance Win32_Processor).Name

# Festplatte (C:) berechnen
$disk = Get-CimInstance Win32_LogicalDisk -Filter "DeviceID='C:'"
$diskTotal = [math]::Round($disk.Size / 1GB, 0)
$diskFree  = [math]::Round($disk.FreeSpace / 1GB, 0)
$diskUsed  = $diskTotal - $diskFree
$diskPct   = [math]::Round(($diskUsed / $diskTotal) * 100, 0)
$sys_disk  = "$diskUsed GiB / $diskTotal GiB ($diskPct%)"

# RAM berechnen
$compSystem = Get-CimInstance Win32_ComputerSystem
$ramTotal   = [math]::Round($compSystem.TotalPhysicalMemory / 1GB, 1)
$ramFree    = [math]::Round((Get-CimInstance Win32_OperatingSystem).FreePhysicalMemory / 1MB, 1)
$ramUsed    = [math]::Round($ramTotal - $ramFree, 1)
$ramPct     = [math]::Round(($ramUsed / $ramTotal) * 100, 0)
$sys_memory = "$ramUsed GiB / $ramTotal GiB ($ramPct%)"


# --- AUTOMATISCHE BREITENBERECHNUNG ---
$allValues = @($sys_user, $sys_uptime, $sys_os, $sys_kernel, $sys_res, $sys_term, $sys_shell, $sys_pkgs, $sys_cpu, $sys_disk, $sys_memory)
$contentWidth = 15 # Mindestbreite für die Farbpunkte
foreach ($val in $allValues) {
    if ($val.Length -gt $contentWidth) { $contentWidth = $val.Length }
}

# Rahmenzeichen festlegen (Sichere Unicode-Codepoints)
$vLineChar = [char]0x2502
$vLine     = $white + $vLineChar

# Exakte mathematische Breite für Deckel, Boden und Trennlinie
# Auf +11 angepasst, damit die Box mit JetBrains Mono NF bündig schließt
$hLine     = [string]([char]0x2500) * ($contentWidth + 17)

$topBox    = [char]0x256D + $hLine + [char]0x256E
$middleBox = [char]0x251C + $hLine + [char]0x2524
$bottomBox = [char]0x2570 + $hLine + [char]0x256F

# Kernfunktion: Baut jede Zeile exakt gleich breit
function Get-ExactLine {
    param ($iconCode, $label, $value)
    $textBlock = "$value"
    $padLength = $contentWidth - $textBlock.Length
    $spaces = " " * $padLength
    
    # Kombiniert das dynamische Hex-Icon mit dem Label
    $fullLabel = "$([char]$iconCode) $label"
    
    return " $white$vLineChar $white$fullLabel$vLineChar $white$textBlock$spaces $vLineChar$reset"
}

# Funktion für die runden Farbpunkte (Simuliert Fastfetch mit "circle")
function info_custom_color_dots {
    $esc = [char]27
    $dot = [char]0x25CF
    $dots = "$($esc)[30m$dot $($esc)[31m$dot $($esc)[32m$dot $($esc)[33m$dot $($esc)[34m$dot $($esc)[35m$dot $($esc)[36m$dot $($esc)[37m$dot"
    
    $padLength = $contentWidth - 15
    if ($padLength -lt 0) { $padLength = 0 }
    $spaces = " " * $padLength

    return @{ title = " $white$vLineChar $([char]0xe22b) colors     $vLineChar $dots$spaces $vLineChar$reset"; content = "" }
}

# Winfetch-Custom-Funktionen für die Ausgabe (Icons werden per Hex übergeben)
function info_custom_top { return @{ title = " $white$topBox$reset"; content = "" } }
function info_custom_mid { return @{ title = " $white$middleBox$reset"; content = "" } }
function info_custom_bottom { return @{ title = " $white$bottomBox$reset"; content = "" } }

function info_custom_title { return @{ title = (Get-ExactLine 0xF007 "user       " $sys_user); content = "" } }
function info_custom_uptime { return @{ title = (Get-ExactLine 0xE385 "uptime     " $sys_uptime); content = "" } }
function info_custom_os { return @{ title = (Get-ExactLine 0xe62a "OS         " $sys_os); content = "" } }
function info_custom_kernel { return @{ title = (Get-ExactLine 0xF036 "kernel     " $sys_kernel); content = "" } }
function info_custom_terminal { return @{ title = (Get-ExactLine 0xF120 "term       " $sys_term); content = "" } }
function info_custom_pwsh { return @{ title = (Get-ExactLine 0xe691 "shell      " $sys_shell); content = "" } }
function info_custom_pkgs { return @{ title = (Get-ExactLine 0xf487 "pkgs       " $sys_pkgs); content = "" } }
function info_custom_cpu { return @{ title = (Get-ExactLine 0xF4BC "cpu        " $sys_cpu); content = "" } }
function info_custom_disk { return @{ title = (Get-ExactLine 0xF0A0 "disk       " $sys_disk); content = "" } }
function info_custom_memory { return @{ title = (Get-ExactLine 0xF019 "memory     " $sys_memory); content = "" } }

# Winfetch-Reihenfolge zur Ausgabe der Box
@(
    "custom_top"
    "custom_title"
    "custom_uptime"
    "custom_os"
    "custom_kernel"
    "custom_terminal"
    "custom_pwsh"
    "custom_pkgs"
    "custom_cpu"
    "custom_disk"
    "custom_memory"
    "custom_mid"
    "custom_color_dots"
    "custom_bottom"
)
