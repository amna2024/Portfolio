#Hämta alla tjänster i Windows
Get-Service

#hämta alla jänster i Windows Displayname och visa endast 
Get-Service | Select-Object Displayname

#hämta alla jänster i Windows och exportera till en text fil
Get-Service | Out-File -FilePath 
Get-Service | Select-Object Displayname, Status | Out-File -FilePath C:\powershell\new.txt

#Hämta alla tjänster och exportera till fil men endast Displayname och status ska exportera
Get-Service | Out-File C:\powershell\new.txt | Select-Object Displayname

#Hämta alla tjänster och filtera sedan visa resultat
Get-Service | Where-Object {$_.Status -like "running"}

#Hämta alla tjänster och exportera till fil men endast service som är stopped och Displayname och status ska exportera till text fil
Get-Service | where-object {$_.status -like "stop*"} | Select-Object Displayname, Status

#lista filer och mappar under powershell folder
Get-ChildItem -Path C:\powershell

#hämta information i text filem och lista i powershell
#Get-Content -Path 'C:\powershell\New Text Document.txt'

#hämta information i text filen och filtera endast "running" sedan visa i powershell
#Get-Service | Out-File -path C:\powershell\hello | Select-Object Displayname, Status

#Get-Help | Get-Service | Out-File -Path C:\powershell\hello | Select-Object Displayname, Status
#Get-ChildItem -Path C:\powershell|
