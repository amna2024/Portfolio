# PowerShell Menu Script Documentation
This PowerShell script provides an interactive menu to perform various tasks related to virtual machine (VM) management, Active Directory (AD) roles, DHCP (Dynamic Host Configuration Protocol), and more. The script uses functions to encapsulate different tasks, and users can navigate through the menu to execute specific actions.

# Functions
#new-create-vm
This function creates a new VM using Hyper-V. The user is prompted to enter the VM name, and the script configures the VM with specified settings such as memory, processor count, and disk.

# new-intsallaionADrole
Installs Active Directory (AD) role and related features on a specified VM. The user is prompted to enter the VM name, and the script uses PowerShell remoting to install the AD role on the target VM.

# new-installingdhcp
Installs and configures DHCP on a specified VM. The user is prompted to enter the VM name, and the script uses PowerShell remoting to set up DHCP scopes, options, and restart the DHCP service.

# aexport-newvm
Exports a specified VM. The user is prompted to enter the VM name, and the script exports the VM to a specified path.

# remove-newvm
Removes a specified VM. The user is prompted to enter the VM name, and the script removes the VM along with associated files.

# list-vm
Lists all available VMs.

# show-menu
Displays the interactive menu with options for different tasks.

4. Execute the selected task.

## Menu Options

1. **Create VM:** Deploy a new virtual machine.
2. **Add AD Role:** Install Active Directory role on a VM.
3. **Add DHCP:** Install DHCP role and configure settings on a VM.
4. **Export VM:** Export a VM to a specified path.
5. **Remove VM:** Remove a specified VM, including its files.
6. **List VMs:** Display a list of available VMs.
Q. **Quit:** Exit the menu.

Feel free to contribute, report issues, or suggest improvements.

**Note:** Ensure you have the necessary permissions and prerequisites for the specified tasks.
--------
Certainly! Here is your PowerShell script documented in a Markdown file:

```markdown
# PowerShell Script Documentation

The PowerShell script provided below is designed for managing various tasks related to VM creation, Active Directory, DHCP, VM export, and VM removal. Each function within the script serves a specific purpose.

## `new-create-vm`

This function creates a new VM with the specified parameters, such as name, memory, and network settings.

```powershell
Function new-create-vm {
    $VName = read-host -Prompt "Name the VM"

    New-VM -Name $VName -Path "C:\VM\vm" -SwitchName "LAN" -MemoryStartupBytes 2048MB -Generation 2
    Set-VMProcessor -VMname $VName -Count 2
    set-VM -Name $VName -AutomaticCheckpointsEnabled $false 
    New-VHD  -Path "C:\VM\$($vname).vhdx" -Differencing -ParentPath "C:\VM\vm temple\sysprep server19.vhdx" 
    Add-VMHardDiskDrive -VMName $Vname -path "C:\VM\$($VName).vhdx" 
    # Disabling checkpoints
    set-vm -name $VName -CheckpointType Disabled
}
```

## `new-intsallaionADrole`

This function installs the Active Directory role and necessary features on a specified VM.

```powershell
function new-intsallaionADrole {
    $VName = read-host -Prompt "Name the VM"
    $username = "administrator"
    $password1 = ConvertTo-SecureString "Amna1234" -AsPlainText -Force
    $credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $username, $Password1

    Invoke-Command -VMName $VName -Credential ($Credential) -ScriptBlock {
        Install-windowsfeature -Name ad-domain-services -IncludeManagementTools
        Install-WindowsFeature RSAT-AD-Powershell
        Install-WindowsFeature RSAT-ADDS
    }
}
```

## `new-installingdhcp`

This function installs the DHCP role and configures DHCP scope on a specified VM.

```powershell
Function new-installingdhcp {
    $VName = read-host -Prompt "Name the VM"
    param($VMName, $credential)

    Invoke-Command -VMName $VName -Credential $credential -ScriptBlock {
        Install-WindowsFeature -Name DHCP -IncludeManagementToo
        # Add DHCP Scope
        Add-DhcpServerV4Scope -Name "mstile Scope 150-200" -StartRange $using:StartRange -EndRange $using:EndRange -SubnetMask $using:Subnet
        # Add DNS server and Router
        Set-DhcpServerV4OptionValue -DnsServer $using:DNSServerIP -Router $using:Router
        # Set up lease duration
        Set-DhcpServerv4Scope -ScopeId 192.168.100.10 -LeaseDuration 1.00:00:00
        # Restart the service
        Restart-service dhcpserver
    }
}
```

## `aexport-newvm`

This function exports a specified VM to a designated path.

```powershell
function aexport-newvm {
    $VName = read-host -Prompt "Name the VM"
    Export-VM -Name $vname -Path C:\VM\vm\export.vm
}
```

## `remove-newvm`

This function removes a specified VM, including its files and exported content.

```powershell
function remove-newvm {
    $VName = read-host -Prompt "Name the VM"
    Remove-VM -name $vname
    Remove-item -Path C:\VM\vm\$($VName) -Force
    Remove-Item -Path C:\VM\vm\export.vm\$($VName) -Force 
}
```

## `list-vm`

This function lists all available VMs.

```powershell
function list-vm {
    get-vm | format-table 
}
```

## `show-menu`

This function displays the main menu with options for different tasks.

```powershell
function show-menu {
    param(
        # Values you supply to the function for utilization
        [string]$title = "My Menu"
    )
    Clear-Host
    Write-Host "------------$title---------"
    Write-Host "1: Create VM." 
    Write-Host "2: Add AD Role."
    Write-Host "3: Add DHCP."
    Write-Host "4: Export VM."
    Write-Host "5: Remove VM."
    Write-Host "6: List of VM."
    Write-Host "Q: Quit."
}
```

## How to Use

1. Run the script in a PowerShell environment.
2. Select an option from the displayed menu by entering the corresponding number.
3. Follow the prompts to provide necessary information for each task.
4. Execute the selected task.

Feel free to contribute, report issues, or suggest improvements. Note: Ensure you have the necessary permissions and prerequisites for the specified tasks.
