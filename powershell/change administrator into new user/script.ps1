
#Change the Administrator to som user
Get-LocalUser -Name "Volvo-admin" | Rename-LocalUser -NewName "xyz" -Confirm
Set-LocalUser -Name "xyz" -FullName "xyz" -Confirm

#change the password
Set-LocalUser -Name "xyz" -Password (ConvertTo-SecureString -AsPlainText "xyz123456789" -Force)

#change computer name 
Rename-Computer -ComputerName DESKTOP-TD7H6G5 -NewName "comp-01" -Force -Restart
