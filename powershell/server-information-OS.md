# Server Information Script

## Description

This PowerShell script collects essential system details and network information from a Windows Server 2022 environment. It retrieves data on the computer system, operating system, processor, disks, network adapters, and domain affiliation.

## Usage

1. **Run the Script:**
   Execute the PowerShell script to gather server information.

2. **Output File:**
   The server information is saved in a text file at the following path:
   `C:\temp\Server2022.txt`

3. **Information Included:**
   - **System Information:**
     - Computer Name
     - Operating System
     - Windows Version
     - Processor
     - Memory

   - **Disk Information:**
     - Drive
     - Model
     - Size

   - **Network Information:**
     - Adapter
     - IP Address
     - Subnet Mask
     - DHCP Enabled
     - Default Gateway
     - DNS Servers
     - DHCP Scope Range (if accessible)

   - **Domain Information:**
     - Domain affiliation

4. **Markdown Document:**
   - Refer to the [Markdown document](./ServerInfoDocumentation.md) for additional details.

---

## Script Content

```powershell
# Set the path for the output file
$outputFilePath = "C:\temp\Server2022.txt"

# Get basic system information
$systemInfo = Get-CimInstance -ClassName Win32_ComputerSystem

# Get operating system information
$osInfo = Get-CimInstance -ClassName Win32_OperatingSystem

# Get processor information
$processorInfo = Get-CimInstance -ClassName Win32_Processor

# Get disk information
$diskInfo = Get-CimInstance -ClassName Win32_DiskDrive

# Get network information
$networkInfo = Get-CimInstance -ClassName Win32_NetworkAdapterConfiguration | Where-Object { $_.IPAddress -ne $null }

# Create a StringBuilder to store information
$report = New-Object System.Text.StringBuilder

# Append server information to the StringBuilder
$report.AppendLine("Server Information")
$report.AppendLine("------------------")
$report.AppendLine("Computer Name: $($systemInfo.Name)")
$report.AppendLine("Operating System: $($osInfo.Caption)")
$report.AppendLine("Windows Version: $($osInfo.Version)")
$report.AppendLine("Processor: $($processorInfo.Name)")
$report.AppendLine("Memory: $($systemInfo.TotalPhysicalMemory / 1GB) GB")

# Append disk information to the StringBuilder
$report.AppendLine("`nDisk Information")
$report.AppendLine("----------------")
foreach ($disk in $diskInfo) {
    $report.AppendLine("Drive: $($disk.DeviceID)")
    $report.AppendLine("   Model: $($disk.Model)")
    $report.AppendLine("   Size: $($disk.Size / 1GB) GB")
}

# Append network information to the StringBuilder
$report.AppendLine("`nNetwork Information")
$report.AppendLine("-------------------")
foreach ($adapter in $networkInfo) {
    $report.AppendLine("Adapter: $($adapter.Description)")
    $report.AppendLine("   IP Address: $($adapter.IPAddress -join ', ')")
    $report.AppendLine("   Subnet Mask: $($adapter.IPSubnet -join ', ')")
    $report.AppendLine("   DHCP Enabled: $($adapter.DHCPEnabled)")
    $report.AppendLine("   Default Gateway: $($adapter.DefaultIPGateway -join ', ')")
    $report.AppendLine("   DNS Servers: $($adapter.DNSServerSearchOrder -join ', ')")

    # DHCP Scope Information (Assuming DHCP server is accessible)
    try {
        $dhcpScope = Get-DhcpServerv4Scope -ComputerName $adapter.DHCPServer
        $report.AppendLine("   DHCP Scope Range: $($dhcpScope.ScopeID) - Start: $($dhcpScope.StartRange), End: $($dhcpScope.EndRange)")
    } catch {
        $report.AppendLine("   Unable to retrieve DHCP Scope information.")
    }
}

# Get domain information
$domainInfo = Get-CimInstance Win32_ComputerSystem
$report.AppendLine("`nDomain Information")
$report.AppendLine("------------------")
$report.AppendLine("Domain: $($domainInfo.Domain)")

# Write the content to the output file
$report.ToString() | Out-File -FilePath $outputFilePath -Encoding UTF8

Write-Host "Server information saved to: $outputFilePath"
```

---

## Notes

- Run the script with appropriate permissions.
- Adjust file paths and names as needed.
- The script uses PowerShell cmdlets like `Get-CimInstance` and `Get-DhcpServerv4Scope`. Ensure these cmdlets are available in your PowerShell environment.
