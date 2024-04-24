# User changable variables
$VName = "W2-AD-01"
$VMPath = (Get-VMHost).VirtualMachinePath | ForEach-Object {$_.Substring(0, $_.Length -1)}
$DifferencingVHDPath = "$VMPath\$VName\$VName.vhdx"
# $ParentVHDPath = "C:\Hyper-V\VHDS\Server22Template\Virtual Hard Disks\Server22.vhdx"
$ParentVHDPath = "D:\Hyper-V\VHDS\Server2022_Sysprep\Virtual Hard Disks\Server2022.vhdx"
$TotalMemory = 4GB
$TotalCores = 4

# Don't change below this line
$LAN = "LAN"
$domain = "Rstile.se"
$username = "Administrator"
$password = ConvertTo-SecureString "Sommar2020" -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential($username, $password)
$IP = "192.168.100.2"
$IP_MASK = 24
$GATE = "192.168.100.1"
$DNS = "192.168.100.2"


function SetupWindowsServer {
    if(-not (Test-Path $ParentVHDPath)) {
        Write-Host "Parent VHD not found:`n$ParentVHDPath"
        exit 1
    }

    # Create a new differencing disk based on the sysprepped VHDX file
    New-VHD -Path $DifferencingVHDPath -ParentPath $ParentVHDPath -Differencing

    # Create a new virtual machine
    $vm = New-VM -Name $VName -MemoryStartupBytes $TotalMemory -Generation 2 -Path $VMPath -SwitchName $LAN

    # Add the differencing disk to the new VM
    Add-VMHardDiskDrive -VMName $VName -Path $DifferencingVHDPath

    # Configure the VM: set the number of processors and disable automatic checkpoints
    Set-VMProcessor -VMName $VName -Count $TotalCores
    Set-VM -Name $VName -AutomaticCheckpointsEnabled $false
    Set-VM -Name $VName -CheckpointType Disabled

    $HD = Get-VMHardDiskDrive -VMName $VName
    Set-VMFirmware $VName -FirstBootDevice $HD

    # Start the VM
    $vm | Start-VM 
}

function Wait {
    Start-Sleep 2
    $loop = $true;
    while($loop) {
        try {
            $service = Invoke-Command -VMName $VName -Credential $cred -ScriptBlock { 
                Get-Service
            } -ErrorAction Stop
            if($null -eq $($service)) {
                throw ""
            }
            else {
                $loop = $false
            }
        }
        catch {
            Write-Host "Wait..." -ForegroundColor Yellow
            start-sleep -Seconds 5
        }
    }
}

function BasicNetworkConfig {
    Invoke-Command -VMName $VName -Credential $cred -ScriptBlock {
        # Static IP Configurations of IP, Gateway, DNs
        New-NetIPAddress -IPAddress $using:IP -PrefixLength $using:IP_MASK -DefaultGateway $using:GATE -InterfaceAlias "Ethernet"
        Set-DnsClientServerAddress -InterfaceAlias "Ethernet" -ServerAddresses $using:DNS
        
    #Set computername to "AD-01"
        Rename-Computer -NewName $using:VName -Force

        #Need to restart the Computer
        Restart-Computer -Force
    }
}

function InstallADDS {
    Invoke-Command -VMName $VName -Credential $cred -ScriptBlock {
        # Join Domain AD-01 serer

        ###Installera Active Directory###
    Install-windowsFeature "Ad-Domain-Services" -IncludeManagementTools

    ###Promote AD## 
    Install-ADDSForest -domainname $using:domain -SafeModeAdministratorPassword $using:password -Confirm:$false
    }
}

function OpenVMConnect {
    # Open a VMConnect window for the started VM
    $localHostName = (Get-ComputerInfo).CsName
    Start-Process "vmconnect.exe" -ArgumentList "$localHostName $VName"
}

function RunScript {
    SetupWindowsServer
    Wait
    BasicNetworkConfig
    Wait
    InstallADDS
    Start-Sleep 10
    OpenVMConnect
}

RunScript
