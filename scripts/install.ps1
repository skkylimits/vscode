###############################
########## Settings ###########
###############################

# Zet de URL van je settings
$settingsUrl = "https://raw.githubusercontent.com/skkylimits/vscode/refs/heads/main/.vscode/settings.json"

# VS Code settings pad (Windows)
$settingsPath = "$env:APPDATA\Code\User"
$settingsFile = "$settingsPath\settings.json"

# Zorg dat de map bestaat
if (-not (Test-Path $settingsPath)) {
    New-Item -ItemType Directory -Path $settingsPath -Force
}

# Verwijder oud bestand als het bestaat
if (Test-Path $settingsFile) {
    Remove-Item $settingsFile -Force
}

# Download de settings
Invoke-WebRequest -Uri $settingsUrl -OutFile $settingsFile

Write-Host "VS Code settings zijn geïnstalleerd in $settingsPath"


###############################
########## Snippets ###########
###############################

# Zet de URL van je snippets
$snippetUrl = "https://raw.githubusercontent.com/skkylimits/vscode/refs/heads/main/.vscode/global.code-snippets"

# VS Code snippets pad (Windows)
$snippetsPath = "$env:APPDATA\Code\User\snippets"
$snippetFile = "$snippetsPath\global.code-snippets"

# Zorg dat de map bestaat
if (-not (Test-Path $snippetsPath)) {
    New-Item -ItemType Directory -Path $snippetsPath -Force
}

# Verwijder oud bestand als het bestaat
if (Test-Path $snippetFile) {
    Remove-Item $snippetFile -Force
}

# Download de snippets
Invoke-WebRequest -Uri $snippetUrl -OutFile $snippetFile

Write-Host "Snippets zijn geïnstalleerd in $snippetsPath"

###############################
##########    Sync    #########
###############################
# Settings ✅
# Keyboard Shortcuts ✅
# Snippets ✅
# Tasks
# MCP Servers
# UI state
# Extensions
# Profiles
# Prom and Instructions
