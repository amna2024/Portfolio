# Get information about the operating system
$os = Get-CimInstance Win32_OperatingSystem

# Get information about physical disks
$physicalDisks = Get-PhysicalDisk

foreach ($disk in $physicalDisks) {
    Write-Host "Disk $($disk.DeviceId)"
    Write-Host "  MediaType: $($disk.MediaType)"
    Write-Host "  Size: $($disk.Size) bytes"
    Write-Host "  HealthStatus: $($disk.HealthStatus)"
    Write-Host "  OperationalStatus: $($disk.OperationalStatus)"
    Write-Host "  Usage: $($disk.Usage)"
    Write-Host "  FriendlyName: $($disk.FriendlyName)"
    Write-Host "  SerialNumber: $($disk.SerialNumber)"
    Write-Host "  ------------"
}

# Get information about partitions and volumes
$volumes = Get-Disk | Get-Partition | Get-Volume

foreach ($volume in $volumes) {
    Write-Host "Volume $($volume.DriveLetter):"
    Write-Host "  FileSystem: $($volume.FileSystem)"
    Write-Host "  Size: $($volume.Size) bytes"
    Write-Host "  FreeSpace: $($volume.FreeSpace) bytes"
    Write-Host "  DriveType: $($volume.DriveType)"
    Write-Host "  ------------"
}

# Skapa en textsträng med variabler
$textAttSkriva = "Användarnamn: $env:USERNAME `nPC-Namn: $env:COMPUTERNAME `nOS: $($os.Caption) ´nharddisk: $($physicalDisks.Count)"

# Ange sökvägen och filnamnet för den nya textfilen
$txtfil = "C:\temp\text.txt"

if (!(Test-Path "C:\temp")) {
    New-Item -Path "C:\temp" -ItemType Directory
}

# Skapa eller öppna filen för att skriva
try {
    # Öppna eller skapa filen för skrivning
    $fil = New-Object System.IO.StreamWriter $txtfil

    # Skriv texten till filen
    $fil.WriteLine($textAttSkriva)
    
    Write-Host "Textfilen har skapats och innehållet har skrivits."

} catch {
    Write-Host "Ett fel uppstod: $_"
} finally {
    # Stäng filen även om det uppstår ett fel
    if ($fil -ne $null) {
        $fil.Close()
    }
}
