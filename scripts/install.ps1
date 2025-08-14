###############################
########## Settings ###########
###############################

# Zet de URL van je settings
$settingsUrl = "https://raw.githubusercontent.com/skkylimits/vscode/refs/heads/main/.vscode/settings.json"

# VS Code settings pad (Windows)
$settingsPath = "$env:APPDATA\Code\User"
$settingsFile = "$settingsPath\settings.json"

###############################
########### Install ###########
###############################

# Definieer alle items: settings, keybindings, snippets
$items = @(
    @{ Name="Settings";       Url="https://raw.githubusercontent.com/skkylimits/vscode/refs/heads/main/.vscode/settings.json";       Path="$env:APPDATA\Code\User"; File="settings.json" },
    @{ Name="Keybindings";    Url="https://raw.githubusercontent.com/skkylimits/vscode/refs/heads/main/.vscode/keybindings.json";    Path="$env:APPDATA\Code\User"; File="keybindings.json" },
    @{ Name="Snippets";       Url="https://raw.githubusercontent.com/skkylimits/vscode/refs/heads/main/.vscode/global.code-snippets"; Path="$env:APPDATA\Code\User\snippets"; File="global.code-snippets" }
)

# Loop door elk item
foreach ($item in $items) {
    # Zorg dat de map bestaat
    if (-not (Test-Path $item.Path)) {
        New-Item -ItemType Directory -Path $item.Path -Force | Out-Null
    }

    $fullPath = Join-Path $item.Path $item.File

    # Verwijder oud bestand als het bestaat
    if (Test-Path $fullPath) {
        Remove-Item $fullPath -Force
    }

    # Download het bestand
    Invoke-WebRequest -Uri $item.Url -OutFile $fullPath

    Write-Host "$($item.Name) is geïnstalleerd in $($item.Path)"
}

Write-Host "✅ Alles is gesynchroniseerd: Settings, Keybindings, Snippets"

#####################################
##########    Extensions    #########
#####################################

# URL van je extensions.json
$extensionsUrl = "https://raw.githubusercontent.com/skkylimits/vscode/refs/heads/main/.vscode/extensions.json"

# Tijdelijk bestand voor de JSON
$tmpFile = "$env:TEMP\extensions.json"

# Download het JSON bestand
Invoke-WebRequest -Uri $extensionsUrl -OutFile $tmpFile

# Lees het JSON bestand
$extensions = Get-Content $tmpFile | ConvertFrom-Json

# Loop door alle recommendations en installeer
foreach ($ext in $extensions.recommendations) {
    if ($ext -and -not ($ext.StartsWith("//"))) {  # negeer commented lines
        Write-Host "Installing $ext..."
        code --install-extension $ext --force
    }
}

Write-Host "Alle extensies zijn geïnstalleerd."

###############################
##########    Sync    #########
###############################
# Settings ✅
# Keyboard Shortcuts ✅
# Snippets ✅
# Tasks ✅
# MCP Servers
# UI state ✅
# Extensions ✅
# Profiles
# Prompt and Instructions
