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

code --install-extension ms-vscode-remote.remote-wsl `
     --install-extension antfu.browse-lite `
     --install-extension antfu.file-nesting `
     --install-extension antfu.iconify `
     --install-extension antfu.open-in-github-button `
     --install-extension antfu.vite `
     --install-extension antfu.where-am-i `
     --install-extension fabiospampinato.vscode-open-in-github `
     --install-extension file-icons.file-icons `
     --install-extension github.copilot `
     --install-extension github.copilot-chat

###############################
##########    Sync    #########
###############################
# Settings ✅
# Keyboard Shortcuts ✅
# Snippets ✅
# Tasks ✅
# MCP Servers
# UI state ✅
# Extensions
# Profiles
# Prompt and Instructions
