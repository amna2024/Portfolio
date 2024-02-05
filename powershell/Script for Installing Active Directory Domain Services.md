## PowerShell Script for Installing Active Directory Domain Services

### Script Overview
This PowerShell script automates the installation and configuration of Active Directory Domain Services (AD DS) on a Windows Server. It includes the necessary steps for setting up a new forest, configuring domain settings, and installing the required features.

### Script Details

```powershell
# Install required Windows features
Install-WindowsFeature -Name ad-domain-services
Install-WindowsFeature RSAT-AD-Powershell
Install-WindowsFeature RSAT-ADDS

# Import ADDS Deployment module
Import-Module ADDSDeployment

# Install and configure AD DS Forest
Install-ADDSForest -CreateDnsDelegation $false `
                  -DatabasePath C:\Windows\NTDS `
                  -DomainName mstile.se `
                  -DomainMode WinThreshold `
                  -DomainNetbiosName MSTILE `
                  -ForestMode WinThreshold `
                  -InstallDns $true `
                  -LogPath C:\Windows\NTDS `
                  -NoRebootOnCompletion $false `
                  -SysvolPath C:\Windows\SYSVOL `
                  -Force $true
```

### Usage Instructions

1. **Run the Script:** Execute the script in a PowerShell environment on a Windows Server where you intend to install AD DS.
2. **Review Settings:** Customize the script parameters based on your specific requirements, such as domain name (`-DomainName`), forest mode (`-ForestMode`), and others.
3. **Installation:** The script installs the specified Windows features, imports the ADDS Deployment module, and proceeds with installing and configuring AD DS.

### Considerations

- **Permissions:** Ensure that the account executing the script has sufficient privileges to install and configure AD DS.
- **Adjust Settings:** Modify script parameters to suit your organization's naming conventions and requirements.
- **Reboot:** The script might trigger a reboot based on the `-NoRebootOnCompletion` parameter. Adjust as needed.

### Example Scenario

Suppose you want to set up a new Active Directory domain named `mstile.se` with forest and domain modes set to `WinThreshold`. This script, when executed, will automate the installation and configuration of AD DS for this scenario.

### Note

This script is designed for setting up AD DS on a Windows Server. Review and customize the parameters according to your specific needs before deploying in a production environment.

Feel free to modify this document to include any additional details or instructions specific to your use case.
