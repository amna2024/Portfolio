#windows10
$VName = "window"
New-VM -Name $VName -Path "C:\VM\vm" -SwitchName "LAN" -MemoryStartupBytes 1048MB -Generation 2
Set-VMProcessor -VMname $VName -Count 2 
set-VM -Name $VName -AutomaticCheckpointsEnabled $false 
New-VHD  -Path "C:\VM\$($vname).vhdx" -Differencing -ParentPath 'C:\VM\vm temple\temple10\orginal temple 10.vhdx' 
Add-VMHardDiskDrive -VMName $($Vname) -path "C:\VM\$($VName).vhdx" 
set-vm -name $VName -CheckpointType Disabled
