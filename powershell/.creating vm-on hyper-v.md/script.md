# Detailed Documentation: Windows 11 Pro Server Configuration

This document outlines the configuration tasks performed on a Windows 11 Pro virtual machine (VM) named "PR ad." The tasks include VM creation, network configuration, Active Directory (AD) setup, organizational unit (OU) creation, user import, group creation, and folder sharing. Additionally, the document emphasizes the usage of a Sysprep-based virtual hard disk.

### Virtual Machine Creation

1. **VM Creation:**
   - Name: `PR ad`
   - Path: `C:\VM\vm`
   - Switch Name: `LAN`
   - Memory: `2048MB`
   - Generation: `2`

   ```powershell
   $VName = "PR ad"
   New-VM -Name $VName -Path "C:\VM\vm" -SwitchName "LAN" -MemoryStartupBytes 2048MB -Generation 2
   Set-VMProcessor -VMname $VName -Count 4
   set-VM -Name $VName -AutomaticCheckpointsEnabled $false
   New-VHD -Path "C:\VM\$($VName).vhdx" -Differencing -ParentPath 'C:\VM\vm temple\veck47 ad.vhdx'
   Add-VMHardDiskDrive -VMName $($Vname) -path "C:\VM\$($VName).vhdx"
   Rename-VM -Name "vecka47 ad" -NewName $VName
   $vname = $VName  # Update the variable for consistency
   ```

2. **Network Configuration:**
   - IP Address: `192.168.100.11`
   - Subnet Mask: `255.255.255.0`
   - Default Gateway: `192.168.100.1`

   ```powershell
   Invoke-Command -VMName $vname -Credential (Get-Credential) -ScriptBlock {
       New-NetIPAddress -IPAddress "192.168.100.11" -PrefixLength 24 -DefaultGateway "192.168.100.1" -InterfaceAlias "Ethernet"
       Set-DnsClientServerAddress -InterfaceAlias "Ethernet" -ServerAddresses "192.168.100.11"
   }
   ```

3. **Computer Name Change:**
   - New Computer Name: `ad01`

   ```powershell
   Invoke-Command -VMName $vname -Credential (Get-Credential) -ScriptBlock {
       Rename-Computer -ComputerName "-pc" -NewName "ad01"
   }
   ```

4. **Restarting the Server:**

   ```powershell
   Invoke-Command -VMName $vname -Credential (Get-Credential) -ScriptBlock {
       Restart-Computer -ComputerName "-pc" -Force
   }
   ```

### Active Directory Configuration

5. **Installing Forest:**
   - Domain Name: `sweden.se`
   - Domain Mode: `WinThreshold`
   - Forest Mode: `WinThreshold`

   ```powershell
   Invoke-Command -VMName $VName -Credential (Get-Credential) -ScriptBlock {
       Import-Module ADDSDeployment
       Install-ADDSForest -CreateDnsDelegation:$false -DatabasePath C:\Windows\NTDS -DomainName sweden.se -DomainMode WinThreshold -DomainNetbiosName MSTILE -ForestMode WinThreshold -InstallDns:$true -LogPath:C:\Windows\NTDS -NoRebootOnCompletion:$false -SysvolPath:C:\Windows\SYSVOL -Force:$true
   }
   ```

### Organizational Unit (OU) Creation

6. **Creating OU:**
   - Name: `sweden-user`

   ```powershell
   Invoke-Command -VMName $VName -Credential (Get-Credential) -ScriptBlock {
       New-ADOrganizationalUnit -Name "sweden-user" -Path "DC=sweden,DC=se"
   }
   ```

### User and Group Configuration

7. **Importing CSV and Creating Users:**
   - CSV Path: `C:\VM\csv\user - user.csv`
   - Password: `Amna1234`

   ```powershell
   $CSV = import-csv -Path "C:\VM\csv\user - user.csv"
   $DomainName = "sweden"
   $AdminUserName = "administrator"
   $AdminPassword = ConvertTo-SecureString "Amna1234" -AsPlainText -Force
   $DomainCredentials = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $DomainName\$AdminUserName, $AdminPassword

   Invoke-Command -VMName $vname -Credential $DomainCredentials -ScriptBlock {
       # PowerShell script to create users from CSV
       # ...
   }
   ```

8. **Creating Sub-OUs and Security Groups:**
   - Sub-OUs: `ekonomi`, `HR`, `Marknad`
   - Security Groups: `sec-gemensem`, `sec-sales`, `sec-Marknad`

   ```powershell
   Invoke-Command -VMName $vname -Credential $DomainCredentials -ScriptBlock {
       # PowerShell script to create Sub-OUs and Security Groups
       # ...
   }
   ```

9. **Adding Members to Security Groups:**

   ```powershell
   Invoke-Command -VMName $vname -Credential $DomainCredentials -ScriptBlock {
       # PowerShell script to add members to Security Groups
       # ...
   }
   ```

10. **Moving Security Groups to OUs:**

   ```powershell
   Invoke-Command -VMName $vname -Credential $DomainCredentials -ScriptBlock {
       # PowerShell script to move Security Groups to OUs
       # ...
   }
   ```

11. **Creating Shared Folders:**
     ```powershell
Invoke-Command -VMName $vname -Credential $DomainCredentials -ScriptBlock {
    # Define paths for shared folders
    $sharedFolderPaths = @("D:\SharedFolder", "D:\SharedFolder\gemensem", "D:\SharedFolder\a")

    # Create shared folders
    foreach ($folderPath in $sharedFolderPaths) {
        New-Item -Path $folderPath -ItemType Directory -Force
        $acl = Get-Acl -Path $folderPath
        $rule = New-Object System.Security.AccessControl.FileSystemAccessRule("Everyone", "FullControl", "ContainerInherit,ObjectInherit", "None", "Allow")
        $acl.AddAccessRule($rule)
        Set-Acl -Path $folderPath -AclObject $acl
    }
}
 ```
