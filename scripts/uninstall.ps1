# Backup extensies
code --list-extensions > "$env:USERPROFILE\vscode_extensions_backup.txt" ; `
code --list-extensions --remote wsl:Ubuntu > "$env:USERPROFILE\vscode_extensions_backup_wsl.txt" ; `
# Uninstall local extensions
code --list-extensions | % { code --uninstall-extension $_ } ; `
# Uninstall WSL Ubuntu extensions
code --list-extensions --loc wsl:Ubuntu | % { code --uninstall-extension $_ } ; `
# Remove config & extension folders
Remove-Item "$env:APPDATA\Code" -Recurse -Force -ErrorAction SilentlyContinue ; `
Remove-Item "$env:USERPROFILE\.vscode" -Recurse -Force -ErrorAction SilentlyContinue ; `
Remove-Item "$env:USERPROFILE\vs-code-remotewsl" -Recurse -Force -ErrorAction SilentlyContinue ; `
# Remove WSL VS Code server
wsl bash -c "rm -rf ~/.vscode-remote-containers ~/.vscode-server"
