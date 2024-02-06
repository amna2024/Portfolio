# PowerShell Script: Automated Virtual Machine Deployment

This PowerShell script automates the deployment and management of virtual machines (VMs) using Hyper-V on Windows Server.

## Create VM Switch

The script begins by creating a virtual switch named `LAN1` using the New-VMSwitch cmdlet with a switch type of Private.

```powershell
New-VMSwitch -Name LAN1 -SwitchType Private
Get-VMSwitch
```

## Create New Disk

Next, the script creates a new virtual hard disk (VHD) named `vm01.vhdx` with a size of 120GB and a dynamic allocation.

```powershell
New-VHD -Path "c:\vm\vm01\vm01.vhdx" -SizeBytes 120GB -Dynamic
```

## Create VM

The script then creates a virtual machine named `VM01` with 2GB of memory, boots from the specified VHD, and connects to the `LAN1` switch.

```powershell
New-VM -Name VM01 -MemoryStartupBytes 2GB -VHDPath c:\vm\vm01\vm01.vhdx -Path c:\vm -Generation 2 -Switch LAN1
```

## Configure VM Processor

The script configures the VM processor to use 2 virtual CPUs.

```powershell
Set-VMProcessor -VMName VM01 -Count 2
```

## Add DVD Drive

A DVD drive is added to the VM, enabling it to boot from an ISO image.

```powershell
Add-VMDvdDrive -VMName VM01 -Path 'C:\VM\Windows 10.iso'
```

## Disable Checkpoints

Checkpoints are disabled for the VM to ensure that no automatic checkpoints are created.

```powershell
Set-VM -Name VM01 -AutomaticCheckpointsEnabled $false -CheckpointType Disabled
```

## Delete VM, VHD, and Switch (Cleanup)

The script includes commands to delete the VM, VHD, and virtual switch, if needed.

```powershell
Remove-VM -Name vm01
Remove-Item -Path c:\vm\vm01\vm01.vhdx -Force
Remove-VMSwitch -Name LAN1 -Force
```

## Variable Usage

A variable `$vswitch` is defined to allow easy customization of the switch name. This variable is then used in subsequent commands.

```powershell
$vswitch = LAN1
New-VMSwitch -Name $vswitch -SwitchType Private
```

This PowerShell script streamlines the creation, configuration, and management of virtual machines, providing flexibility and efficiency in virtualized environments.
```
