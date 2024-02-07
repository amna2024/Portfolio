# Network Information Script

## Description

This PowerShell script gathers essential network information and saves it to a text file. The script retrieves details about shared folders, IP addresses, DNS servers, and the default gateway.

## Usage

1. **Run the Script:**
   Execute the PowerShell script to collect network information.

2. **Output File:**
   The network information is stored in a text file at the following path:
   `C:\Temp\Server_Network_IP_DNS_GW_ShareFolder_Info.txt`

3. **Information Included:**
   - **Shared Folders:** A list of shared folders on the server.
   - **IP Addresses:** The IP addresses associated with the 'Ethernet' interface.
   - **DNS Servers:** DNS server addresses configured on the 'Ethernet' interface.
   - **Gateway:** The default gateway.

4. **Markdown Document:**
   - Refer to the [Markdown document](./NetworkInfoDocumentation.md) for additional details.

---

## Script Content

```powershell
# Funktion för att hämta DNS-servrar
function Get-DNSServers { 
    return $((Get-DnsClientServerAddress | Where-Object { $_.InterfaceAlias -eq 'Ethernet'}).ServerAddresses -join ", ")
}

# Sökväg till textfilen
$outputFilePath = "C:\Temp\Server_Network_IP_DNS_GW_ShareFolder_Info.txt"

# Skapa en sammanhängande sträng med alla delade mappar åtskilda med kommatecken och mellanslag
$sharedFolders = (Get-SharedFolders) -join ", "

# Skapa en sammanhängande sträng med all nätverksinformation
$networkInfo = @"
Share folders: $sharedFolders
IP: $(Get-IPAddresses -join ", ")
DNS: $(Get-DNSServers)
Gateway: $(Get-Gateway)
"@

# Skriv all nätverksinformation till textfilen
$networkInfo | Out-File -FilePath $outputFilePath -Encoding utf8
Write-Host "Nätverksinformationen har sparats till: $outputFilePath"
# Öppna textfilen automatiskt
Invoke-Item $outputFilePath
```

---

## Notes

- Make sure to run the script with appropriate permissions.
- Adjust the file paths and names as needed.
- The script relies on PowerShell cmdlets such as `Get-DnsClientServerAddress`, `Get-SharedFolders`, `Get-IPAddresses`, and `Get-Gateway`. Ensure these cmdlets are available in your PowerShell environment.
