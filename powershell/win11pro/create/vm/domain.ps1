# CreateVM.ps1
$VName = "w2-W11Pro"
$VMPath = "D:\Hyper-V\VMs"
$ParentVHDPath = "D:\Hyper-V\VHDS\Win11_Sysprep\Virtual Hard Disks\Win11.vhdx"  # Uppdaterad sÃ¶kvÃ¤g till den sysprepade VHDX
$DifferencingVHDPath = "$VMPath\$VName\$VName.vhdx"
$TotalMemory = 5GB
$TotalCores = 5
$LAN = "LAN"
$username = "User"
$domain = "Rstile.se"
$Domainname = "Rstile\Administrator"
$password = ConvertTo-SecureString "Sommar2020" -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential($username, $password)
$dcred = New-Object System.Management.Automation.PSCredential($Domainname, $password)
$IP = "192.168.100.3"
$IP_MASK = 24
$GATE = "192.168.100.1"
$DNS = "192.168.100.2"

# Kontrollera om mappen for VM:n existerar, om inte skapa den
if (-not (Test-Path $VMPath)) {
    New-Item -Path $VMPath -ItemType Directory
}

# Skapa en ny differencing disk baserad pÃ¥ den sysprepade VHDX-filen
New-VHD -Path $DifferencingVHDPath -ParentPath $ParentVHDPath -Differencing

# Skapa en ny virtuell maskin
$vm = New-VM -Name $VName -MemoryStartupBytes $TotalMemory -Generation 2 -Path $VMPath -SwitchName $LAN

# LÃ¤gg till differencing-disken till den nya VM
Add-VMHardDiskDrive -VMName $VName -Path $DifferencingVHDPath

# Konfigurera VM: stÃ¤ll in antalet processorer och inaktivera automatiska checkpoints
Set-VMProcessor -VMName $VName -Count $TotalCores
Set-VM -Name $VName -AutomaticCheckpointsEnabled $false
Set-VM -Name $VName -CheckpointType Disabled

# HÃ¤mta VM-objektet
$vm = Get-VM -Name $VName

$HD = Get-VMHardDiskDrive -VMName $VName
Set-VMFirmware $VName -FirstBootDevice $HD

# Starta VM
$vm | Start-VM

function wait {
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

Wait
Invoke-Command -VMName $VName -Credential $cred -ScriptBlock {
    Rename-Computer -NewName $using:VName -Force

    #Need to restart the Computer
    Restart-Computer -Force
}

Wait
Invoke-Command -VMName $VName -Credential $cred -ScriptBlock {
    # Static IP Configurations of IP, Gateway, DNs
    New-NetIPAddress -IPAddress $using:IP -PrefixLength $using:IP_MASK -DefaultGateway $using:GATE -InterfaceAlias "Ethernet"
    Set-DnsClientServerAddress -InterfaceAlias "Ethernet" -ServerAddresses $using:DNS
  
}

Wait
Invoke-Command -VMName $VName -Credential $cred -ScriptBlock {
    Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False

    Add-Computer -ComputerName $using:VName -DomainName $using:domain -Credential $using:dcred -Restart
}
$cred = $dcred

# Ã–ppna ett VMConnect-fÃ¶nster fÃ¶r den startade VM:n
$localHostName = (Get-ComputerInfo).CsName
Start-Process "vmconnect.exe" -ArgumentList "$localHostName $VName"
