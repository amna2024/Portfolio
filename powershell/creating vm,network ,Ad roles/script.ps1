
$VName = "pull server"
New-VM -Name $VName -Path "C:\VM\vm" -SwitchName "LAN" -MemoryStartupBytes 2048MB -Generation 2
Set-VMProcessor -VMname $VName -Count 2
set-VM -Name $VName -AutomaticCheckpointsEnabled $false 
New-VHD  -Path "C:\VM\$($vname).vhdx" -Differencing -ParentPath 'C:\VM\vm temple\sysprep server19.vhdx' 
Add-VMHardDiskDrive -VMName $($Vname) -path "C:\VM\$($VName).vhdx" 
#disableing check points
set-vm -name $VName -CheckpointType Disabled


#windows10
$VName = "window10new"
New-VM -Name $VName -Path "C:\VM\vm" -SwitchName "LAN" -MemoryStartupBytes 1048MB -Generation 2
Set-VMProcessor -VMname $VName -Count 2 
set-VM -Name $VName -AutomaticCheckpointsEnabled $false 
New-VHD  -Path "C:\VM\$($vname).vhdx" -Differencing -ParentPath 'C:\VM\vm temple\temple10\orginal temple 10.vhdx' 
Add-VMHardDiskDrive -VMName $($Vname) -path "C:\VM\$($VName).vhdx" 
set-vm -name $VName -CheckpointType Disabled


 
#rename of vm
Rename-VM -Name "vecka47 ad" -NewName "PR ad"
$vname="PR ad"

#disableing check points
set-vm -name $VName -CheckpointType Disabled
 #start vm
Start-VM -vmname $VName

$vname= "ad01"

$username="administrator"
$password1= ConvertTo-SecureString "Amna1234" -AsPlainText -Force
$credentail=New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $username, $Password1

#ip address
Invoke-Command -VMName $vname  -Credential ($credentail) -ScriptBlock{

    New-NetIPAddress -IPAddress "192.168.100.10" -PrefixLength 24 -DefaultGateway "192.168.100.1" -InterfaceAlias "Ethernet"
    Set-DnsClientServerAddress -InterfaceAlias "Ethernet" -ServerAddresses "192.168.100.10"

}





#chaning computer name
$vname= "ad01"
$username="administrator"
$password1= ConvertTo-SecureString "Amna1234" -AsPlainText -Force
$credentail=New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $username, $Password1
Invoke-Command -VMName $vname  -Credential ($credentail) -ScriptBlock{
Rename-Computer -ComputerName "-pc" -NewName "AD01" 
} 

Invoke-Command -VMName $vname  -Credential ($credentail) -ScriptBlock{
Restart-Computer -ComputerName "-pc" -Force
}


#restarting the server for changing name
Invoke-Command -VMName $vname  -Credential (Get-Credential) -ScriptBlock{
Restart-Computer -ComputerName "-pc" -Force
}
$vname= "ad"
$username="administrator"
$password1= ConvertTo-SecureString "Amna1234" -AsPlainText -Force
$credentail=New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $username, $Password1


Invoke-Command -VMName $VName -Credential ($Credentail) -ScriptBlock{
Install-windowsfeature  -Name ad-domain-services -IncludeManagementTools
Install-WindowsFeature RSAT-AD-Powershell
Install-WindowsFeature RSAT-ADDS
}

Invoke-Command -VMName $VName -Credential ($credentail) -ScriptBlock{
Import-Module ADDSDeployment 
Install-ADDSForest -CreateDnsDelegation: $false
Install-ADDSForest -DatabasePath C:\Windows\NTDS  
Install-ADDSForest -DomainName Vstile.se
Install-ADDSForest -DomainMode WinThreshold
Install-ADDSForest -DomainNetbiosName VSTILE
Install-ADDSForest -ForestMode WinThreshold
Install-ADDSForest -InstallDns: $true
Install-ADDSForest -LogPath:  C:\Windows\NTDS
Install-ADDSForest -NoRebootOnCompletion: $false
Install-ADDSForest -SysvolPath: C:\Windows\SYSVOL 
Install-ADDSForest -Force: $true

}

Invoke-Command -VMName $VName -Credential ($credential) -scriptblock {

   $DNSServerIP = "192.168.100.10"
    $DHCPServerIP = "192.168.100.10"
    $StartRange = "192.168.100.150"
    $EndRange = "192.168.100.200"
    $Subnet = "255.255.255.0"
    $Router = "192.168.100.1"

    #Add DHCP Scope
    Add-DhcpServerV4Scope -Name "vstile Scope 150-200" -StartRange $StartRange -EndRange $EndRange -SubnetMask $Subnet
    #Add DNS server and Router
    Set-DhcpServerV4OptionValue -DnsServer $DNSServerIP -Router $Router
    #Set up lease duration
    Set-DhcpServerv4Scope -ScopeId 192.168.100.10 -LeaseDuration 1.00:00:00
    #Restart the service
    Restart-service dhcpserver


} 

Invoke-Command -VMName $VName -Credential (Get-credential) -scriptblock {

Install-WindowsFeature -Name DHCP -IncludeManagementToo
Add-DhcpServerV4Scope -Name "DHCP Scope" -StartRange 192.168.100.100 -EndRange 192.168.100.200 -SubnetMask 255.255.255.0
Add-DhcpServerv4ExclusionRange -ComputerName "AD01" -StartRange 192.168.100.100 -EndRange 192.168.10.200
Set-DhcpServerV4OptionValue -DnsServer 192.168.10.11 -Router 192.168.10.1
Set-DhcpServerv4Scope -ScopeId 192.168.10.10 -LeaseDuration 200:00:00
Set-DhcpServerV4OptionValue -DnsDomain "vstile.se"
Restart-service dhcpserver
}

Invoke-Command -VMName $VName -Credential ($DomainCredentials) -scriptblock {
New-ADOrganizationalUnit -Name "exchange" -Path "DC=vstile,DC=com"
 }
#creating OU
Invoke-Command -VMName $VName -Credential (Get-credential) -scriptblock {
New-ADOrganizationalUnit -Name "mstile-user" -Path "DC=mstile,DC=se"
 }

#importing csv and putting user in it

$CSV = import-csv -Path "C:\csv\user.csv" 
$DomainName = "vstile"
$AdminUserName = "administrator"
$AdminPassword = ConvertTo-SecureString "Amna1234" -AsPlainText -Force
$DomainCredentials = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $DomainName\$AdminUserName, $AdminPassword


Invoke-Command -VMName $vname -Credential $DomainCredentials -ScriptBlock {

    $CSV = $using:CSV

    $Oupath = "ou=exchange,dc=vstile,dc=com"
    $password = ConvertTo-SecureString "Amna1234" -AsPlainText -Force
    $domain = "@vstile.com"

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
 

Invoke-Command -VMName $vname -Credential $DomainCredentials -ScriptBlock {

    $CSV = $using:CSV

    $Oupath = "ou=mstile-STO,dc=mstile,dc=com"
    $password = ConvertTo-SecureString "Amna1234" -AsPlainText -Force
    $domain = "@mstile.se"

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
 

 #creating sub OU in OU.
Invoke-Command -VMName $vname -Credential $DomainCredentials -ScriptBlock {
  $Oupath = "ou=mstile-user,dc=mstile,dc=se"
    $password = ConvertTo-SecureString "Amna1234" -AsPlainText -Force
    $domain = "@sweden.se"

New-ADOrganizationalUnit -Name "STO" -Path $Oupath
New-ADOrganizationalUnit -Name "GBG" -Path $Oupath }

New-ADOrganizationalUnit -Name "Marknad" -Path $Oupath
}



   #sec-group
Invoke-Command -VMName $vname -Credential $DomainCredentials -ScriptBlock {
  $Oupath = "ou=mstile-user,dc=mstile,dc=se"
    $password = ConvertTo-SecureString "Amna1234" -AsPlainText -Force
    $domain = "@mstile.com"
New-ADGroup -Name "sec-sto"  -GroupScope Global  -GroupCategory Security -Path $Oupath}
New-ADGroup -Name "sec-gbg" -GroupScope Global  -GroupCategory Security -Path $Oupath}

New-ADGroup -Name "sec-Marknad" -GroupScope Global  -GroupCategory Security -Path $Oupath

}
#putting member in thier respective sec groups

Invoke-Command -VMName $vname -Credential $DomainCredentials -ScriptBlock {
  $Oupath = "ou=sweden-user,dc=sweden,dc=se"
Get-ADGroup -SearchBase $Oupath -Filter "name -like 'sec-GBg'" | Add-ADGroupMember -Members "marcus johansson","Patrik karlsson","jessica gröt","Linn kasten","tor petrovski"}

Invoke-Command -VMName $vname -Credential $DomainCredentials -ScriptBlock {
  $Oupath = "ou=sweden-user,dc=sweden,dc=se"
Get-ADGroup -SearchBase $Oupath -Filter "name -like 'sec-gemensem'" | Add-ADGroupMember -Members "jessica gröt","Bertil Johansson","linn kasten","malin helander","Nazish arat","marcus johansson","Patrik karlsson","jesper mikaelsson","Anna frejinge","malin helander"
}

Invoke-Command -VMName $vname -Credential $DomainCredentials -ScriptBlock {
  $Oupath = "ou=sweden-user,dc=sweden,dc=se"
get-ADGroup -SearchBase $Oupath -Filter "name -like 'sec-sto'" | Add-ADGroupMember -Members "marcus johansson","Patrik karlsson","jesper mikaelsson","Anna frejinge","malin helander"
}

Invoke-Command -VMName $vname -Credential $DomainCredentials -ScriptBlock {
  $Oupath = "ou=sweden-user,dc=sweden,dc=se"
Get-ADGroup -SearchBase $Oupath -Filter "name -like 'sec-gemensem'" | Add-ADGroupMember -Members "jessica gröt","Bertil Johansson","linn kasten","malin helander","Nazish arat","marcus johansson","Patrik karlsson","jesper mikaelsson","Anna frejinge","malin helander"
}

#senind sec-group to OU through powershell in ad server
 Invoke-Command -VMName $vname -Credential $DomainCredentials -ScriptBlock {
 Move-ADObject -Identity "CN=sec-sto,OU=sweden-user,DC=sweden,DC=se" -TargetPath "OU=sto,OU=sweden-user,DC=sweden,DC=se" 
 }

 
#creating share folder in ad server
Invoke-Command -VMName $vname -Credential $DomainCredentials  -ScriptBlock {
New-Item "C:\SharedFolder" -itemType Directory
}


Invoke-Command -VMName $vname -Credential $DomainCredentials  -ScriptBlock {
New-Item "C:\SharedFolder\mstiledata" -itemType Directory
}

#senind sec-group to OU through powershell in ad server
 Move-ADObject -Identity "CN=sec-ekonomi,OU=sweden-user,DC=sweden,DC=se" -TargetPath "OU=Ekonomi,OU=sweden-user,DC=sweden,DC=se" 
 
#creating share folder in ad server
Invoke-Command -VMName $vname -Credential $DomainCredentials  -ScriptBlock {
New-Item "c:\SharedFolder" -itemType Directory
}


Invoke-Command -VMName $vname -Credential $DomainCredentials  -ScriptBlock {
New-Item "D:\SharedFolder\a" -itemType Directory 
}
#entering powershell of vm of frist ad
$session = New-PSSession -VMName movauto -Credential (Get-Credential)
Enter-PSSession $session

#sending all the things to new ad and making it the root domain
##Demote DomainController
netdom query fsmo

##Fetch PDCEmulator (see location)
Get-ADDomain | Select-Object -Property PDCEmulator

##move the FSMO-Roles
Move-ADDirectoryServerOperationMasterRole `
-OperationMasterRole SchemaMaster,DomainNamingMaster,PDCEmulator,RIDMaster,InfrastructureMaster -Identity movauto1

#uninstall ADDSDomaincontroller
Uninstall-ADDSDomainController `
-Credential (Get-Credential) `
-DemoteOperationMasterRole:$true `
-IgnoreLastDnsServerForZone:$true `
-RemoveDnsDelegation:$false `
-LastDomainControllerInDomain:$false `
-Force:$true

#uninstall WindowsFeature
Uninstall-WindowsFeature AD-Domain-Services -IncludeManagementTools


import-csv -Path "C:\VM\csv\StockholmAnvandare.csv"

$path="C:\VM\vm\movauto1\Virtual Machines\B9D54758-CF2E-41D4-868A-FC1CD3BD7256.vmcx"

Remove-Item -Path "C:\VM\vm\movauto1"

Get-Item -Path "C:\VM\vm\movauto1"

 get-process - "$file" | stop-process


  $file = Get-ChildItem  -LiteralPath $path
        $stream = $file.OpenRead()
        ...
        $stream.Close()




        #remove vm
        remove-vm -name $vmname
        Start-Sleep


#change varibale upto your desired location and names!
        
