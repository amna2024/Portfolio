# Set the path for the output file (Rashad)
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
