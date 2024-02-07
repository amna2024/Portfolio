$VName = "vecka47 CD"
New-VM -Name $VName -Path "C:\VM\vm" -SwitchName "LAN" -MemoryStartupBytes 2048MB -Generation 2
Set-VMProcessor -VMname $VName -Count 4
set-VM -Name $VName -AutomaticCheckpointsEnabled $false
New-VHD  -Path "C:\VM\$($vname).vhdx" -Differencing -ParentPath 'C:\VM\vm temple\sysprep server19.vhdx'
Add-VMHardDiskDrive -VMName $($Vname) -path "C:\VM\$($VName).vhdx"


#disableing check points
set-vm -name $VName -CheckpointType Disabled

#creating hard disk in VM
New-VHD -Path C:\VM\vm\BACKUP.vhdx -SizeBytes 10GB 
New-VHD -Path C:\VM\vm\H1.vhdx -SizeBytes 10GB 
New-VHD -Path C:\VM\vm\H2.vhdx -SizeBytes 10GB 
#deleting harddisk
Dismount-VHD -Path C:\VM\vm\backup1.vhdx

#adding hard disk in vm
Add-VMHardDiskDrive -VMName $($Vname) -path  C:\VM\vm\H.vhdx
Add-VMHardDiskDrive -VMName $($Vname) -path  C:\VM\vm\H1.vhdx
Add-VMHardDiskDrive -VMName $($Vname) -path  C:\VM\vm\H2.vhdx
add-VMHardDiskDrive -VMName vecka44 -path C:\VM\hh.vhdx

#ip address
Invoke-Command -VMName $vname  -Credential (Get-Credential) -ScriptBlock{

    New-NetIPAddress -IPAddress "192.168.100.12" -PrefixLength 24 -DefaultGateway "192.168.100.1" -InterfaceAlias "Ethernet"
    Set-DnsClientServerAddress -InterfaceAlias "Ethernet" -ServerAddresses "192.168.100.11"

}

#chaning computer name
Invoke-Command -VMName $vname  -Credential (Get-Credential) -ScriptBlock{
Rename-Computer -ComputerName "-pc" -NewName "cd01" 
}
#restart computer
Invoke-Command -VMName $vname  -Credential (Get-Credential) -ScriptBlock{
Restart-Computer -ComputerName "-pc"  -Force
}
#installing ad role
Invoke-Command -VMName $VName -Credential (Get-Credential) -ScriptBlock{
Install-windowsfeature  -Name ad-domain-services -IncludeManagementTools
Install-WindowsFeature RSAT-AD-Powershell
Install-WindowsFeature RSAT-ADDS
}

$DomainName = "sweden"
$AdminUserName = "administrator"
$AdminPassword = ConvertTo-SecureString "Amna1234" -AsPlainText -Force
$DomainCredentials1 = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $DomainName\$AdminUserName, $AdminPassword


Invoke-Command -VMName $vname  -Credential (Get-Credential) -ScriptBlock{
$DomainName = "sweden"
$AdminUserName = "administrator"
$AdminPassword = ConvertTo-SecureString "Amna1234" -AsPlainText -Force
$DomainCredentials1 = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $DomainName\$AdminUserName, $AdminPassword
Import-Module ADDSDeployment
Install-ADDSDomain `
-NoGlobalCatalog:$false `
-CreateDNSDelegation `
-Credential $DomainCredentials1 `
-DatabasePath "C:\Windows\NTDS" `
-DomainMode "Win2012" `
-DomainType "ChildDomain" `
-InstallDNS:$true `
-LogPath "C:\Windows\NTDS" `
-NewDomainName "best" `
-NewDomainNetBIOSName "BEST" `
-ParentDomainName "sweden.se" `
-Norebootoncompletion:$false `
-SiteName "Default-First-Site-Name" `
-SYSVOLPath "C:\Windows\SYSVOL" `
-Force:$true}

#creating OU
Invoke-Command -VMName $VName -Credential (Get-credential) -scriptblock {
New-ADOrganizationalUnit -Name "best-swede," -Path "Dc=best,DC=sweden,DC=se"
 }

 #importing csv and putting user in it



#importing csv and putting user in it

$CSV = import-csv -Path "C:\VM\csv\Tengil_users_-_Blad1.csv"
$DomainName = "best"
$AdminUserName = "administrator"
$AdminPassword = ConvertTo-SecureString "Amna1234" -AsPlainText -Force
$DomainCredentials = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $DomainName\$AdminUserName, $AdminPassword


Invoke-Command -VMName $VName -Credential $DomainCredentials -ScriptBlock {

    $CSV = $using:CSV

    $Oupath = "ou=best-sweden,dc=best,DC=sweden,dc=se"
    $password = ConvertTo-SecureString "Amna1234" -AsPlainText -Force
    $domain = "@best.se"

    ForEach ($User in $CSV) {

        $username = $user.givenname
        $lastname = $user.surname
        $SAM = $User.sAMAccountName
        $fullname = $username + " " + $lastname
        $userprincipalname= $user.$sam.$domain

        New-ADUser `
        -Path $Oupath `
        -AccountPassword $password `
        -PasswordNotRequired $true `
        -DisplayName $fullname `
        -GivenName $givenname `
        -Name $fullname `
        -SamAccountName $samaccountname `
        -Surname $lastname `
        -UserPrincipalName $userprincipalname `
        -Enabled $true
    }
}

#change file paths and ou names upto your demand!
