# PowerShell Script for Transitioning FSMO Roles and Uninstalling Active Directory Domain Services

This PowerShell script is designed to transition Flexible Single Master Operations (FSMO) roles and uninstall Active Directory Domain Services (AD DS) from a domain controller named `movauto` to a new domain controller, making it the root domain.

## Transition FSMO Roles

```powershell
# Enter PowerShell session on the first domain controller (movauto)
$session = New-PSSession -VMName movauto -Credential (Get-Credential)
Enter-PSSession $session

# Check FSMO roles
netdom query fsmo

# Fetch PDCEmulator
Get-ADDomain | Select-Object -Property PDCEmulator

# Move the FSMO roles to the new domain controller (movauto1)
Move-ADDirectoryServerOperationMasterRole `
    -OperationMasterRole SchemaMaster,DomainNamingMaster,PDCEmulator,RIDMaster,InfrastructureMaster `
    -Identity movauto1
```

## Uninstall AD DS

```powershell
# Uninstall ADDSDomainController
Uninstall-ADDSDomainController `
    -Credential (Get-Credential) `
    -DemoteOperationMasterRole:$true `
    -IgnoreLastDnsServerForZone:$true `
    -RemoveDnsDelegation:$false `
    -LastDomainControllerInDomain:$false `
    -Force:$true

# Uninstall WindowsFeature
Uninstall-WindowsFeature AD-Domain-Services -IncludeManagementTools
```

Make sure to run this script with appropriate credentials and ensure that you have backups and proper planning in place before performing such critical operations on your domain controllers.
```
