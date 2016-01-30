# Description: Boxstarter Script
# Author: Alex Casanova <alexbogus@gmail.com>
# Last Updated: 2016-01-30
#
# Run this boxstarter by calling the following:
# START http://boxstarter.org/package/nr/url?https://gist.githubusercontent.com/<yoururl>/boxstarter.ps1

# Allow running PowerShell scripts
Update-ExecutionPolicy Unrestricted

# Boxstarter options
Import-Module Boxstarter
$Boxstarter.RebootOk=$true # Allow reboots?
$Boxstarter.NoPassword=$false # Is this a machine with no login password?
$Boxstarter.AutoLogin=$true # Save my password securely and auto-login after areboot

#Basic settings for Boxstarter
Set-WindowsExplorerOptions -EnableShowHiddenFilesFoldersDrives -EnableShowProtectedOSFiles -EnableShowFileExtensions -EnableShowFullPathInTitleBar
Set-TaskbarSmall
Enable-RemoteDesktop
Disable-InternetExplorerESC
Disable-UAC


# Update Windows and reboot if necessary
Install-WindowsUpdate -AcceptEula
if (Test-PendingReboot) { Invoke-Reboot }





# to see the details of any of the following go to https://chocolatey.org/packages/PACKAGE_NAME_HERE
# find more package names here: https://chocolatey.org/
# and here `choco list`
# and here `choco list -source windowsfeatures`
Start-Sleep -s 2

#Browsers
cinst -y googlechrome 

# File Sharing / Remote Drives
cinst -y dropbox 
cinst -y evernote 

 

# Multimedia
cinst -y audacity 
cinst -y lame
cinst -y vlc

# Utililties Apps
cinst -y greenshot 
cinst -y ccleaner 

# Backup Apps
cinst -y mozbackup 

# email Apps
cinst -y thunderbird 

# Chat Apps
cinst -y hexchat 

#installing text editors
cinst -y notepadplusplus.install
cinst -y SublimeText3 sublimetext3.packagecontrol
cinst -y sublimetext3.powershellalias 
cinst -y jivkok.sublimetext3.packages 


#installing remote managing tools
cinst -y teamviewer

#Git
cinst -y github


# PowerShell advanced modules
Install-Module PSReadline
Install-Module TabExpansionPlusPlus
Install-Module ZLocation
Install-Module posh-git
cinst -y powergui
cinst -y pscx
cinst -y psget

#installing Some Admin Tools
cinst -y vmwarevsphereclient
cinst -y sysinternals
cinst -y mremoteng 
cinst -y mobaxterm
cinst -y Gow 
cinst -y sysinternals 
cinst -y cmder
cinst -y winscp


# Hardening Section
#
#
#


# Some Tweaks
#
#
#installing taskbar shortcuts
#Install-ChocolateyPinnedTaskBarItem "$($Boxstarter.programFiles)\ConEmu\ConEmu64.exe"
#Install-ChocolateyPinnedTaskBarItem "$($Boxstarter.programFiles)\Sublime Text 3\sublime_text.exe"
#Install-ChocolateyPinnedTaskBarItem "$($Boxstarter.programFiles86)\code4ward.net\Royal TS V3\RTS3App.exe"
#Install-ChocolateyPinnedTaskBarItem "%windir%\system32\WindowsPowerShell\v1.0\PowerShell_ISE.exe"
#Install-ChocolateyPinnedTaskBarItem "$($Boxstarter.programFiles)\Internet Explorer\iexplore.exe"
Install-ChocolateyPinnedTaskBarItem "$($Boxstarter.programFiles)\Google\Chrome\Application\chrome.exe"



# Tell Windows Update not to automatically reboot the machine whenever it sees fit (thanks for that, Microsoft)
Write-Host NoAutoRebootWithLoggedOnUsers registry key:
reg add HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU /v NoAutoRebootWithLoggedOnUsers /t REG_DWORD /d 1 /f

## On Windows 8 (and later) tell Windows not to sleep/lock due to inactivity

If (([Environment]::OSVersion.Version.Major -eq 6 -and [Environment]::OSVersion.Version.Minor -ge 2) -or ([Environment]::OSVersion.Version.Major -ge 7)) {
    Write-Host InactivityTimeoutSecs registry key:
    reg add HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v InactivityTimeoutSecs /t REG_DWORD /d 0 /f
}

#
# Create some commonly used directories under C:\
If (!(Test-Path -Path C:\Temp)) {New-Item -ItemType directory -Path C:\Temp}


# Check Windows Update and if its necessary reboot
Install-WindowsUpdate -acceptEula
if (Test-PendingReboot) { Invoke-Reboot }


# Cleans the WinSxS folder of rollbck files
# Can save quite a bit of space.
# Warning: it also takes a long time.
Write-Host "Cleaning SxS..."
Dism.exe /online /Cleanup-Image /StartComponentCleanup /ResetBase



#################
#### cleanup ####
#################
del C:\eula*.txt
del C:\install.*
del C:\vcredist.*
del C:\vc_red.*


#
# Clean up Boxstarter autologin
# Note: keep this last in the script
###
$winLogonKey="HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"
Remove-ItemProperty -Path $winLogonKey -Name "DefaultUserName" -ErrorAction SilentlyContinue
Remove-ItemProperty -Path $winLogonKey -Name "DefaultDomainName" -ErrorAction SilentlyContinue
Remove-ItemProperty -Path $winLogonKey -Name "DefaultPassword" -ErrorAction SilentlyContinue
Remove-ItemProperty -Path $winLogonKey -Name "AutoAdminLogon" -ErrorAction SilentlyContinue
Enable-UAC



