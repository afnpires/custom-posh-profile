# PowerShell customizations

This repo contains settings to customize PowerShell

## Install
1. Open PowerShell in Administrator Mode
1. Run the following commands:
```powershell
iwr https://chocolatey.org/install.ps1 -UseBasicParsing | iex
Install-Module PSReadline
Install-Module Get-ChildItemColor
Install-Module z -AllowClobber
Install-Module posh-git -Scope CurrentUser
cp Microsoft.Powershell_profile.ps1 '%USERPROFILE%\WindowsPowerShell\'
Unblock-File '%USERPROFILE%\WindowsPowerShell\Microsoft.Powershell_profile.ps1'
``` 
1. Close and reopen PowerShell

## Configure cmder

1. Open cmder configuration > Startup > Tasks
1. Select the `Powershell::Powershell` task and replace the command with the following
```
PowerShell -ExecutionPolicy Bypass -NoLogo -NoProfile -NoExit -Command "Invoke-Expression %USERPROFILE%\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1 -new_console:d:"%USERPROFILE%"
```
