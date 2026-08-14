# +--------------------------------------------------------------------------+
# | ______      __                  _____ __                                 |
# | /_  __/___  / /____  ______     / ___// /_____  _________ ___            |
# |  / / / __ \/ //_/ / / / __ \    \__ \/ __/ __ \/ ___/ __ `__ \           |
# | / / / /_/ / ,< / /_/ / /_/ /   ___/ / /_/ /_/ / /  / / / / / /           |
# |/_/  \____/_/|_|\__, /\____/   /____/\__/\____/_/  /_/ /_/ /_/            |
# |               /____/                                                     |
# +--------------------------------------------------------------------------+

# +--------------------------------------------------------------------------+
# | POWERSHELL PROFILE CONFIGURATION                                         |
# +--------------------------------------------------------------------------+

# $env:STARSHIP_CONFIG = "C:\custom\starship\path\if\exists\starship.toml"
Invoke-Expression (&starship init powershell)


# --- PROFILE MANAGEMENT -----------------------------------------------------

function Edit-Profile { codium "$PROFILE" }
New-Alias -Name ep -Value Edit-Profile -Description "Open profile in VSCodium" -Force


# --- NAVIGATION & DIRECTORIES -----------------------------------------------

function Go-Up { Set-Location .. }
New-Alias -Name .. -Value Go-Up -Description "Go up one directory" -Force

function Go-Up2 { Set-Location ../.. }
New-Alias -Name ... -Value Go-Up2 -Description "Go up two directories" -Force

function List-All { Get-ChildItem -Force | Format-Table Attributes, Name, Length, LastWriteTime }
New-Alias -Name la -Value List-All -Description "List all files with details" -Force

function Make-And-Enter-Directory { param($dir) New-Item -ItemType Directory -Path $dir -Force | Out-Null; Set-Location $dir }
New-Alias -Name mkd -Value Make-And-Enter-Directory -Description "Create directory and enter it" -Force


# --- FILE MANIPULATION ------------------------------------------------------

function Rename-Force { param($path, $newName) Rename-Item -Path $path -NewName $newName -Force }
New-Alias -Name rn -Value Rename-Force -Description "Force rename a file or folder" -Force

function Move-Force { param($src, $dest) Move-Item -Path $src -Destination $dest -Force }
New-Alias -Name mvf -Value Move-Force -Description "Force move a file or folder" -Force

function Remove-Force { param($path) Remove-Item -Path $path -Force -Recurse }
New-Alias -Name rmf -Value Remove-Force -Description "Force delete file/folder and contents" -Force

function Bulk-Rename {
    param($search, $replace)
    Get-ChildItem | Where-Object { $_.Name -match $search } | ForEach-Object {
        $newName = $_.Name -replace $search, $replace
        Rename-Item -Path $_.FullName -NewName $newName -Force
    }
}
New-Alias -Name bren -Value Bulk-Rename -Description "Replace text across multiple file names" -Force


# --- SEARCHING & FILTERING (GREP) -------------------------------------------

function Search-Grep { param($pattern, $path = "*") Select-String -Pattern $pattern -Path $path }
New-Alias -Name grep -Value Search-Grep -Description "Linux-like grep utility for text search" -Force


# --- APP SHORTCUTS & LAUNCHERS ----------------------------------------------

function Open-Codium { param($target = ".") Start-Process codium -ArgumentList $target -ErrorAction SilentlyContinue }
New-Alias -Name code -Value Open-Codium -Description "Open VSCodium" -Force

function Open-Notepad { param($file = "") if ($file) { notepad $file } else { notepad } }
New-Alias -Name np -Value Open-Notepad -Description "Open Notepad" -Force

function Open-Explorer { param($path = ".") Invoke-Item $path }
New-Alias -Name fo -Value Open-Explorer -Description "Open folder in Windows Explorer" -Force

function Open-Browser { param($url = "https://google.com") Start-Process firefox $url -ErrorAction SilentlyContinue }
New-Alias -Name google -Value Open-Browser -Description "Open Google in Browser" -Force


# --- SYSTEM & NETWORK -------------------------------------------------------

function Flush-DNS { Clear-DnsClientCache; ipconfig /flushdns }
New-Alias -Name fdns -Value Flush-DNS -Description "Flush local DNS cache" -Force

function Get-MyIP { Get-NetIPAddress -AddressFamily IPv4 | Where-Object IPAddress -notmatch "127.0.0.1" | Select-Object IPAddress, InterfaceAlias }
New-Alias -Name myip -Value Get-MyIP -Description "Show active local IPv4 addresses" -Force

New-Alias -Name c -Value Clear-Host -Description "Clear the screen quickly" -Force


# --- PRINT -----------------------------------------------------
function Show-Logo {
    $logo = @"

    ████████╗████████╗██╗   ██╗
    ╚══██╔══╝╚══██╔══╝╚██╗ ██╔╝
       ██║      ██║    ╚████╔╝ 
       ██║      ██║     ╚██╔╝  
       ██║      ██║      ██║   
       ╚═╝      ╚═╝      ╚═╝                                                   
"@
    Write-Host $logo -ForegroundColor "Blue"
}


function Show-Box {
    param(
        [Parameter(Mandatory = $true, Position = 0)]
        [string]$text,
        [string]$borderColor = "DarkGray",
        [string]$textColor = "White"
    )
    $topLeft = [char]0x256D; $topRight = [char]0x256E; $botLeft = [char]0x2570; $botRight = [char]0x256F
    $horiz   = [char]0x2500; $vert     = [char]0x2502; $esc     = [char]27

    # Case-insensitive lower-case mapping table for safe rendering
    $colorMap = @{
        "black"="30"; "darkblue"="34"; "darkgreen"="32"; "darkcyan"="36"; "darkred"="31"; "darkmagenta"="35"
        "darkyellow"="33"; "gray"="37"; "darkgray"="90"; "blue"="94"; "green"="92"; "cyan"="96"
        "red"="91"; "magenta"="95"; "yellow"="93"; "white"="97"
    }

    $lines = $text -split "`r?`n"
    
    # Calculate box spacing dimensions safely by filtering brackets
    $maxLength = 0
    $cleanLines = foreach ($line in $lines) {
        $clean = $line -replace '\[\/?[a-zA-Z]+\]', ""
        if ($clean.Length -gt $maxLength) { $maxLength = $clean.Length }
        $clean
    }

    # Top Border
    Write-Host "$topLeft$([string]$horiz * ($maxLength + 2))$topRight" -ForegroundColor $borderColor

    # Content Lines
    for ($i = 0; $i -lt $lines.Count; $i++) {
        Write-Host "$vert " -NoNewline -ForegroundColor $borderColor

        $stateColor = if ($colorMap.ContainsKey($textColor.ToLower())) { $colorMap[$textColor.ToLower()] } else { "97" }
        $stateStyle = ""

        # Parse active state variables
        foreach ($chunk in ([regex]::Split($lines[$i], '(\[\/?[a-zA-Z]+\])'))) {
            $lowerChunk = $chunk.ToLower()
            if ($lowerChunk -eq "[italic]")  { $stateStyle = "3;" }
            elseif ($lowerChunk -eq "[/italic]") { $stateStyle = "" }
            elseif ($chunk -match '^\[([a-zA-Z]+)\]$') { 
                $extractedColor = $Matches[1].ToLower()
                if ($colorMap.ContainsKey($extractedColor)) { $stateColor = $colorMap[$extractedColor] }
            }
            elseif ($chunk.Length -gt 0) {
                Write-Host "$esc[$($stateStyle)$($stateColor)m$chunk" -NoNewline
            }
        }

        # Clear layout engine parameters for trailing frame components
        Write-Host -NoNewline "$esc[0m"
        Write-Host "$(" " * ($maxLength - $cleanLines[$i].Length)) $vert" -ForegroundColor $borderColor
    }

    # Bottom Border
    Write-Host "$botLeft$([string]$horiz * ($maxLength + 2))$botRight" -ForegroundColor $borderColor
}




New-Alias -Name box -Value Show-Box -Description "Print text inside a rounded box container" -Force


# --- WELCOME BANNER (disable if unwanted) ---------------------------------------------------------

Clear-Host

# TTY Logo
Show-Logo

# Banner
Show-Box @"
[White] Windows 11 - [blue]Tokyo Night [Italic](Storm)[/Italic]

[DarkGray]    ────────Socials────────

[DarkGray]Github      SaturnM7
[DarkGray]IG       @Ilikefish700

[DarkGray]  ───────────────────────────

[Italic][DarkGray]        Rice by SaturnMZ[/Italic]
[Italic][DarkGray]            Enjoy ;)[/Italic]

[DarkGray]        ────────────────

"@ -borderColor "DarkGray" -textColor "Gray"

Write-Host ""

