###############################
########## Settings ###########
###############################

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
