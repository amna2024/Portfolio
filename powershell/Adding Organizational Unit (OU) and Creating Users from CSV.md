# PowerShell Script for Adding Organizational Unit (OU) and Creating Users from CSV

This PowerShell script is designed to add an Organizational Unit (OU) named `mstile1` in the `mstile.se` domain and create user accounts based on information provided in a CSV file.

## Add OU and Import CSV File

```powershell
# Add Organizational Unit (OU)
New-ADOrganizationalUnit -Name "mstile1" -Path "DC=mstile,DC=se"

# Import CSV file containing user information
$CSV = Import-Csv -Path 'C:\user - user.csv'
$Oupath = "ou=mstile1,dc=mstile,dc=se"
$password = "xyz1234"
$domain = "@mstile.se"
#add any passwrod and domain of your choice
# Iterate through each user in the CSV file and create AD user accounts
ForEach ($User in $CSV) {
    $username = $User.givenname
    $lastname = $User.surname
    $SAM = $User.sAMAccountName
    $fullname = $username + " " + $lastname
    $userprincipalname= $User.$sam.$domain

    # Create new AD user
    New-ADUser -Path $Oupath `
        -AccountPassword (ConvertTo-SecureString $password -AsPlainText -Force) `
        -PasswordNotRequired $true `
        -DisplayName $fullname `
        -GivenName $username `
        -Name $fullname `
        -SamAccountName $SAM `
        -Surname $lastname `
        -UserPrincipalName $userprincipalname `
        -Enabled $true
}
```

Ensure that the CSV file (`user - user.csv`) contains the necessary user information and adjust the file path accordingly. Also, make sure to run this script with appropriate permissions and review the parameters before execution.


