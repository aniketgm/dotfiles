#Requires -RunAsAdministrator
#Requires -Version 7.0

$ErrorActionPreference = 'Ignore'

# Write console message. Options: -a -> add new line, -i -> add install msg
function WriteMsg($MsgText, [Switch]$AddEmptyLine ,[Switch]$Install)
{
  If ($AddEmptyLine.IsPresent) { Write-Output "" } # Empty line for readability
  If ($Install.IsPresent) { Write-Output "Installing $MsgText.." }
  Else { Write-Output $MsgText }
}

# Main
If (-Not (Get-Command -Name rotz))
{
  WriteMsg -a "Rotz not found. Rotz is required for further setup."
  WriteMsg "Install Rotz and re-run the script again. See README for more details"
}
ElseIf (-Not (Get-Command -Name winget))
{
  WriteMsg -a "Winget not found. Usually it comes by default with Windows 10+ installations."
  WriteMsg "Winget is required. Check out winget-cli on github on how to install it."
}
ElseIf ((-Not (Get-Command -Name lazygit)) -Or (-Not (Get-Command -Name pwsh)))
{
  ((Get-ExecutionPolicy LocalMachine) -ne "RemoteSigned") -And (Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope LocalMachine)
  rotz install essentials/vcredist
  rotz install essentials/git
  rotz install essentials/lazygit
  rotz install essentials/pwsh
  rotz install essentials/winterm
  WriteMsg -a "Essential softwares are installed. Now restart for the changes to take effect"
  WriteMsg "After restart, re-run the script 'setup.ps1' again to continue with the setup.."
  If (@('Y', 'y') -contains (Read-Host "Restart Now ?(y/n)")) { shutdown /r /t 10 }
  Else { WriteMsg -a "Without restart the setup.ps1 may not function properly if you continue." }
}
ElseIf ((Get-Command -Name scoop) -And ($PSVersionTable.PSVersion.Major -ge 7) -And (Get-Command -Name pwsh))
{
  ((Get-ExecutionPolicy LocalMachine) -ne "RemoteSigned") -And (Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope LocalMachine)
  rotz install editor/*
  rotz install extras/fonts
  rotz install extras/scoop/*

  # Now link everything
  rotz link essentials/git
  rotz link essentials/pwsh
  rotz link editor/*
}
Else
{
  WriteMsg -a "Now script needs Powershell 7 (pwsh) to run further setup."
  WriteMsg "Open Powershell 7 and re-run the 'setup.ps1' script again."
}
