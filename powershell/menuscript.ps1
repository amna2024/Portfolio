Function new-create-vm {
$VName = read-host -Prompt "name the VM"

New-VM -Name $VName -Path "C:\VM\vm" -SwitchName "LAN" -MemoryStartupBytes 2048MB -Generation 2
Set-VMProcessor -VMname $VName -Count 2
set-VM -Name $VName -AutomaticCheckpointsEnabled $false 
New-VHD  -Path "C:\VM\$($vname).vhdx" -Differencing -ParentPath "C:\VM\vm temple\sysprep server19.vhdx" 
Add-VMHardDiskDrive -VMName $Vname -path "C:\VM\$($VName).vhdx" 
#disableing check points
set-vm -name $VName -CheckpointType Disabled

}





function new-intsallaionADrole{
$VName = read-host -Prompt "name the VM"
$username="administrator"
$password1= ConvertTo-SecureString "Amna1234" -AsPlainText -Force
$credentail=New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $username, $Password1


Invoke-Command -VMName $VName -Credential ($Credential) -ScriptBlock{
Install-windowsfeature  -Name ad-domain-services -IncludeManagementTools
Install-WindowsFeature RSAT-AD-Powershell
Install-WindowsFeature RSAT-ADDS
}

}


 
$username="vstileadministrator"
$password1= ConvertTo-SecureString "Amna1234" -AsPlainText -Force
$credential=New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $username, $Password1
$DNSServerIP = "192.168.100.10"
    $DHCPServerIP = "192.168.100.10"
    $StartRange = "192.168.100.150"
    $EndRange = "192.168.100.200"
    $Subnet = "255.255.255.0"
    $Router = "192.168.100.1"
    
    
    
Function new-installingdhcp {
$VName = read-host -Prompt "name the VM"
param(
    $VMName,
    $credential
    )


    
Invoke-Command -VMName $VName -Credential $credential -scriptblock {
     
     Install-WindowsFeature -Name DHCP -IncludeManagementToo
     #Add DHCP Scope
    Add-DhcpServerV4Scope -Name "mstile Scope 150-200" -StartRange $using:StartRange -EndRange $using:EndRange -SubnetMask $using:Subnet
    #Add DNS server and Router
    Set-DhcpServerV4OptionValue -DnsServer $using:DNSServerIP -Router $using:Router
    #Set up lease duration
    Set-DhcpServerv4Scope -ScopeId 192.168.100.10 -LeaseDuration 1.00:00:00
    #Restart the service
    Restart-service dhcpserver
    }
}


function aexport-newvm {
$VName = read-host -Prompt "name the VM"
 Export-VM -Name $vname -Path C:\VM\vm\export.vm

}

function remove-newvm{
$VName = read-host -Prompt "name the VM"
Remove-VM -name $vname
Remove-item -Path C:\VM\vm\$($VName)  -Force
Remove-Item -Path C:\VM\vm\export.vm\$($VName) -Force 

}

function list-vm{
get-vm | format-table 
}



function show-menu{

param(
# just values you supply to the function so that the function can do something utilising those values

[string]$title= "my menu"
)
Clear-Host
Write-Host "------------$title---------"
Write-Host "1: CREATE VM." 
Write-Host "2: ADD AD ROLE."
Write-Host "3: ADD DHCP."
Write-Host "4: Export VM."
Write-Host "5: Remove VM."
Write-Host "6: List of VM."
Write-Host "Q: Quit."

}


do {

show-menu -title "Powershell"

$userinput = Read-Host "Specify from the option above"
switch($userinput) {

   '1' { write-host "deploying the machine" -ForegroundColor Cyan
         #using the varible so can name the created a machine as many as we want "$VName = read-host -Prompt "name the VM"
   
         new-create-vm  
    
       }


    '2' {Write-host "Deploying the Active directory role" -ForegroundColor DarkRed
         #for installation of Active Directory we use the "$VName = read-host -Prompt "name the VM" " so we can install the role on the specfic VM
           
          new-intsallaionADrole           
        }

    '3' {Write-host "Deploying the DHCP role" -ForegroundColor DarkGreen
         #for installation of DHCP we use the "$VName = read-host -Prompt "name the VM" " so we can install the role on the specfic VM,we are using the other variable such as 

         new-installingdhcp 
        }

    '4' {write-host "Removing" -ForegroundColor DarkYellow
         #for exporting vm i m using "$VName = read-host -Prompt "name the VM" so that we can remove the specific vm,and then using the path way to direct it
          aexport-newvm 
        }

    '5' {write-host "Removing" -ForegroundColor DarkYellow
    #for removing vm i m using ""$VName = read-host -Prompt "name the VM"" so that we can remove the specific vm,
    remove-newvm 
    }


    '6'{write-host "List of VM" -ForegroundColor DarkMagenta
     #for listing the vm we are using "get" command
    list-vm
    pause 
    }

}

} until ( $userinput -like "q" ) 
