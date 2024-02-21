# Function to get the amount of physical memory (RAM) in GB
function Get-RAM {
    return [math]::Round((Get-CimInstance -ClassName Win32_PhysicalMemory | Measure-Object -Property Capacity -Sum).Sum / 1GB)
}

# Function to get the number of physical disks (RAID disks)
function Get-RaidDisks {
    return ((Get-PhysicalDisk).Count -1)
}

# Function to retrieve RAID size and type
function Get-RaidInfo {
    try {
        $volumes = "list volume" | diskpart | Where-Object { $_ -match "^  [^-]" } | Select-Object -skip 1

        $raidTypes = @()
        foreach ($row in $volumes) {
            if ($row -match "\s\s(Volume\s\d)\s+([A-Z])\s+(.*)\s\s(NTFS|FAT)\s+(Mirror|RAID-5|Stripe)\s+(\d+)\s+(..)\s\s([A-Za-z]*\s?[A-Za-z]*)(\s\s)*.*") {
                $disk = $matches[2]
                if ($row -match "Mirror") { $raidTypes += "RAID-1" }
                if ($row -match "RAID-5") { $raidTypes += "RAID-5" }
                if ($row -match "Stripe") { $raidTypes += "RAID-0" }
            }
        }

        if ($raidTypes.Count -eq 0) { 
            return "No RAID" 
        } else {
            return $raidTypes -join ", "
        }
    }
    catch {
        write-output "Command has Failed: $($_.Exception.Message)"
    }
}

# Function to retrieve information about the administrator user
function Get-AdminUser {
    $stefan = $("$env:COMPUTERNAME\stefan")
    if(Get-LocalGroupMember -Group "Administrators" | Where-Object { $_.Name -eq $stefan }) {
        return "True"
    }
    else {
        return "False"
    }
}

# Function to retrieve information about the operating system
function Get-OSInfo {
    $osInfo = Get-CimInstance -ClassName Win32_OperatingSystem
    return $osInfo.Caption.Trim('Standard Evaluation')
}

# Function to get the number of processor cores
function Get-TotalCores {
    return (Get-CimInstance -ClassName Win32_Processor).NumberOfLogicalProcessors
}

# Function to retrieve information about logical disks
function Get-RaidSize {
    $logicalDrives = Get-CimInstance -ClassName Win32_LogicalDisk
    $diskInfo = @()
    foreach ($drive in $logicalDrives) {
        $size = [math]::Round($drive.Size / 1GB)
    }
    return $size
}

#Minimum Password Policy
function Get-PasswordPolicy {
    $netAccountsOutput = net accounts
    $minPasswordLength = ($netAccountsOutput | Where-Object { $_ -match 'Minimum password length' }) -replace '\D+(\d+)', '$1'
    return $minPasswordLength
}


# Path to the text file
$outputFilePath = "C:\Temp\Server_Disk_Ram_Raid_User_Info.txt"

# Create the Temp folder if it doesn't exist
if (!(Test-Path "C:\Temp")) {
    New-Item -Path "C:\" -Name "Temp" -ItemType "directory"
    Write-Host "Temp folder created"
}

# Construct a concatenated string with all information
$serverInfo = @"
OS: $(Get-OSInfo)
Cores: $(Get-TotalCores)
RAM: $(Get-RAM) GB
Raid disks: $(Get-RaidDisks)
Raid size: $(Get-RaidSize) GB
Raid type: $(Get-RaidInfo)
Admin user stefan: $(Get-AdminUser)
Minimum Password Policy: $(Get-PasswordPolicy)
"@

# Write all information to the text file
$serverInfo | Out-File -FilePath $outputFilePath -Encoding utf8

Write-Host "Information has been saved to: $outputFilePath"

# Open the text file automatically
Invoke-Item $outputFilePath
