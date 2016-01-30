# References
# http://philchuang.com/index.php/automating-setup-of-your-windows-development-environment-for-fun-and-profit/
# Allow running PowerShell scripts
clear
Write-Host ‘Allow Running PowerShell scripts’ -foregroundcolor DarkGreen -backgroundcolor white
Set-ExecutionPolicy Unrestricted


#
# Check if we're on a domain, and exit if not
#
#If (!(Get-CimInstance -Class Win32_ComputerSystem).PartOfDomain) {
#    Write-Host -ForegroundColor Red "This machine is not part of a domain. Please take care of that first, and then run this script again."
#    exit
#}


# Installing Chocolatey Provider from PowerShell
Write-Host ‘Installing Chocolatey Provider from PowerShell’ -foregroundcolor DarkGreen -backgroundcolor white
Get-PackageProvider –Name Chocolatey -ForceBootstrap
Set-PackageSource -Name chocolatey -Trusted
Find-Package -Name chocolatey | Install-Package -Verbose -Force -Confirm
Start-Sleep -s 3


#Installing Nuget
clear
Write-Host ‘Installing Nuget’ -foregroundcolor DarkGreen -backgroundcolor white
Find-Package -Name NuGet.vs | Install-Package -Verbose -Force -Confirm
Start-Sleep -s 3


# Invoke Boxstarter Script
clear
Write-Host ‘Starting Boxstarter Script’ -foregroundcolor DarkGreen -backgroundcolor white
Start-Sleep -s 3
#$cred=Get-Credential virtual_machine_name\your_account_here
#Install-BoxstarterPackage -PackageName {public_location_of_your_boxstarter_install_script} -Credential $cred
START http://boxstarter.org/package/nr/url?https://gist.githubusercontent.com/alexbogus/70a2fa6f536d8bf6aee2/raw/befbd0750708ce86f92164fa7b4f3469c8efadea/boxstarter.txt
