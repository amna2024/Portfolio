$data = @"
Givenname, Surname, SAMaccountname, SecurityGroup
Maria, Lindgren, maria.lindgren, Marknad
Axel, Sundberg, axel.sundberg, Marknad
Ulf, Svensson, ulf.svensson, Marknad
Lennart, Lundström, lennart.lundstrom, Marknad
Gustav, Forsberg, gustav.forsberg, Marknad
Gunilla, Isaksson, gunilla.isaksson, Sales
Håkan, Lindqvist, hakan.lindqvist, Sales
Malin, Hansson, malin.hansson, Sales
Roland, Åkesson, roland.akesson, Sales
Susanne, Nilsson, susanne.nilsson, Sales
"@

if(-not (Test-Path C:\TEMP)) {
    New-Item -Path C:\TEMP -ItemType Directory
}

$file = "C:\temp\users.csv"

$data | Out-File -FilePath $file -Encoding utf8

$rstile = "OU=Rstile,DC=rstile,DC=se"
$users = Import-Csv "C:\TEMP\users.csv"

###Create new OU Rstile ##
if($null -eq (Get-ADOrganizationalUnit -Filter 'name -eq "Rstile"' -SearchBase "DC=rstile,DC=se")) {
    New-ADOrganizationalUnit -name Rstile
}

foreach($user in $users) {
    $path = "OU=" + $user.SecurityGroup + "," + $rstile

    if($null -eq (Get-ADOrganizationalUnit -Filter "name -eq '$($user.SecurityGroup)'" -SearchBase $rstile)) {
        New-ADOrganizationalUnit -Name $user.SecurityGroup -Path $rstile
    }
    if($null -eq (Get-ADGroup -Filter "SAMaccountName -eq 'sec_$($user.SecurityGroup)'")) {
        New-ADGroup -Name ("sec_" + $user.SecurityGroup) -GroupCategory Security -GroupScope Global -Path $path
    }

    $UserParams = @{
            Path              = $path
            GivenName         = $user.givenname
            Surname           = $user.surname
            Name              = "$($user.givenname) $($user.surname)"
            SamAccountName    = $user.samaccountname
            UserPrincipalName = "$($user.SamAccountName)@Rstile.se"
            AccountPassword   = ConvertTo-SecureString -String "Sommar2020" -AsPlainText -Force
            Enabled           = $true   # Make sure the user is enabled
            PasswordNeverExpires = $true  # Set password to never expire
        }

    New-ADUser @UserParams

    Add-ADGroupMember -Identity ("sec_" + $user.SecurityGroup) -Members $user.SAMaccountname
}
