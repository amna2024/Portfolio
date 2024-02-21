# Creat an adminuser "Stefan" with password "St3fan!23456789"
$username = "xyz"

#Configure a password policy with minimum 15 characters
net accounts /minpwlen:15 

# Generate a secure password
$password = ConvertTo-SecureString "#passwrod" -AsPlainText -Force

# Create the local user
New-LocalUser -Name $username -Password $password -FullName $username -Description "Local User Account" -PasswordNeverExpires:$true

# Add the user to the Administrators group (optional)
Add-LocalGroupMember -Group "Administrators" -Member $username

#Create a Volume called "RAID-5" with the 4 unused disks at 5GB each
$diskpartScript = @"
select disk 1
attributes disk clear readonly
online disk
convert dynamic
select disk 2
attributes disk clear readonly
online disk
convert dynamic
select disk 3
attributes disk clear readonly
online disk
convert dynamic
select disk 4
attributes disk clear readonly
online disk
convert dynamic
create volume raid disk=1,2,3,4
select vol 3
format quick fs=ntfs label=RAID-5
assign letter=S
"@
$diskpartScript | diskpart

# Set computername to "DC-01"
Rename-Computer -NewName "DC-01" -Force

#Need to restart the Computer
Restart-Computer

