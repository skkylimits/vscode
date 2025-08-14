###############################
########### Install ###########
###############################

# Definieer alle items: settings, keybindings, snippets
$items = @(
    @{ Name="Settings";       Url="https://raw.githubusercontent.com/skkylimits/vscode/refs/heads/main/.vscode/settings.json";       Path="$env:APPDATA\Code\User"; File="settings.json"; Type="file" },
    @{ Name="Keybindings";    Url="https://raw.githubusercontent.com/skkylimits/vscode/refs/heads/main/.vscode/keybindings.json";    Path="$env:APPDATA\Code\User"; File="keybindings.json"; Type="file" },
    @{ Name="Snippets";       Url="https://raw.githubusercontent.com/skkylimits/vscode/refs/heads/main/.vscode/global.code-snippets"; Path="$env:APPDATA\Code\User\snippets"; File="global.code-snippets"; Type="file" },
    @{ Name="Extensions";     Url="https://raw.githubusercontent.com/skkylimits/vscode/refs/heads/main/.vscode/extensions.json";     Path="$env:TEMP"; File="extensions.json"; Type="extensions" }
)

foreach ($item in $items) {
    if (-not (Test-Path $item.Path)) { New-Item -ItemType Directory -Path $item.Path -Force | Out-Null }

    $fullPath = Join-Path $item.Path $item.File

    if (Test-Path $fullPath) { Remove-Item $fullPath -Force }

    Invoke-WebRequest -Uri $item.Url -OutFile $fullPath

    if ($item.Type -eq "file") {
        Write-Host "$($item.Name) is geïnstalleerd in $($item.Path)"
    }
    elseif ($item.Type -eq "extensions") {
        # Verwijder commentaarregels en converteer naar object
        $jsonText = Get-Content $fullPath -Raw
        $jsonText = ($jsonText -split "`n" | Where-Object { $_ -notmatch '^\s*//' }) -join "`n"
        $extensions = $jsonText | ConvertFrom-Json

        foreach ($ext in $extensions.recommendations) {
            if ($ext) {
                Write-Host "Installing $ext..."
                code --install-extension $ext --force
            }
        }

        Write-Host "Alle extensies zijn geïnstalleerd."
    }
}

Write-Host "✅ Alles is gesynchroniseerd"

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
