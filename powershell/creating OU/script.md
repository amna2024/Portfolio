```markdown
# Active Directory OU and User Creation Script

## Overview
This script automates the creation of Organizational Units (OUs), user accounts, sub-OUs, and security groups in Active Directory for the "bstile" domain.

### Creating OUs
```powershell
New-ADOrganizationalUnit -Name "bstile-user" -Path "DC=bstile,DC=se"
```

### Creating Users
```powershell
$CSV = Import-Csv -Path "C:\csv\user_-_grupp_7.csv"
$Oupath = "ou=bstile-user,dc=bstile,dc=se"
$password = "Amna1234"
$domain = "@Bstile.se"

ForEach ($User in $CSV) {
    $username = $User.givenname
    $lastname = $User.surname
    $SAM = $User.sAMAccountName
    $fullname = "$username $lastname"
    $userprincipalname = "$SAM$domain"

    New-ADUser -Path $Oupath -AccountPassword (ConvertTo-SecureString $password -AsPlainText -Force) -PasswordNotRequired $true -DisplayName $fullname -GivenName $username -Name $fullname -SamAccountName $SAM -Surname $lastname -UserPrincipalName $userprincipalname -Enabled $true
}
```

### Creating Sub-OUs
```powershell
New-ADOrganizationalUnit -Name "ekonomi" -Path "OU=bstile-user,DC=bstile,DC=se"
New-ADOrganizationalUnit -Name "HR" -Path "OU=bstile-user,DC=bstile,DC=se"
New-ADOrganizationalUnit -Name "Marknad" -Path "OU=bstile-user,DC=bstile,DC=se"
```

### Creating Security Groups
```powershell
New-ADGroup -Name "sec-hr" -SamAccountName "HR" -GroupScope Global -GroupCategory Security -Path "OU=bstile-user,DC=bstile,DC=se"
New-ADGroup -Name "sec-Ekonomi" -SamAccountName "Ekonomi" -GroupScope Global -GroupCategory Security -Path "OU=bstile-user,DC=bstile,DC=se"
New-ADGroup -Name "sec-Marknad" -SamAccountName "marknad" -GroupScope Global -GroupCategory Security -Path "OU=bstile-user,DC=bstile,DC=se"
```

### Adding Members to Security Groups
```powershell
Get-ADGroup -SearchBase "OU=Bstile GOT,DC=Bstile,DC=SE" -Filter "name -like 'SEC_Marknad'" | Add-ADGroupMember -Members marcus.johansson,Patrik.karlsson,Rickard.marklund,Nazish.arat
Get-ADGroup -SearchBase "OU=Bstile GOT,DC=Bstile,DC=SE" -Filter "name -like 'SEC_Ekonomi'" | Add-ADGroupMember -Members jesper.mikaelsson,Anna.freijing,Bertil.Johansson,Nazish.arat
Get-ADGroup -SearchBase "OU=Bstile GOT,DC=Bstile,DC=SE" -Filter "name -like 'SEC_HR'" | Add-ADGroupMember -Members jessica.gröt,linn.kasten,malin.helander,Nazish.arat
```

## Usage
1. Run the script in a PowerShell environment.
2. Review Active Directory to verify the creation of OUs, user accounts, sub-OUs, and security groups.

**Note:** Ensure the script is executed with appropriate permissions and on a machine connected to the "bstile" domain. Review and adjust security practices before deploying in a production environment.
```

| instead of bstile you can use any name what your domain has,same option for password,ounames and csv file!
