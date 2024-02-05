# DHCP Server Installation and Configuration

## Overview

This document outlines the steps to install and configure a DHCP (Dynamic Host Configuration Protocol) server on a Windows Server machine. DHCP is a network protocol that automatically assigns IP addresses and other network configuration information to devices on a network.

## Prerequisites

- Windows Server installed and configured.
- Administrative privileges on the server.
- A basic understanding of networking concepts.

## Installation Steps

1. **Install DHCP Server Role:**
    ```powershell
    Install-WindowsFeature -Name DHCP -IncludeManagementTools
    ```

2. **Create DHCP Scope:**
    - Add a DHCP scope to define the range of IP addresses that the DHCP server can assign.
    ```powershell
    Add-DhcpServerV4Scope -Name "DHCP Scope" -StartRange 192.168.100.100 -EndRange 192.168.100.115 -SubnetMask 255.255.255.0
    ```

3. **Exclude IP Range:**
    - Exclude certain IP addresses from the DHCP scope to prevent them from being assigned.
    ```powershell
    Add-DhcpServerv4ExclusionRange -ComputerName "ad01" -StartRange 192.168.100.100 -EndRange 192.168.100.104
    ```

4. **Set DHCP Options:**
    - Configure DHCP options such as DNS server, router, and domain name.
    ```powershell
    Set-DhcpServerV4OptionValue -DnsServer 192.168.100.10 -Router 192.168.100.1
    Set-DhcpServerV4OptionValue -DnsDomain "bstile.se"
    ```

5. **Configure Lease Duration:**
    - Set the lease duration for IP addresses in the DHCP scope.
    ```powershell
    Set-DhcpServerv4Scope -ScopeId 192.168.100.10 -LeaseDuration 200:00:00
    ```

6. **Restart DHCP Service:**
    - Restart the DHCP service to apply the changes.
    ```powershell
    Restart-Service dhcpserv
    ```

## Usage Instructions

1. **Client Configuration:**
    - Ensure that client devices are configured to obtain IP addresses automatically (DHCP-enabled).

2. **Network Testing:**
    - Test the DHCP configuration by connecting devices to the network and verifying that they receive IP addresses within the configured range.

## Considerations

- **IP Address Range:** Define an IP address range that provides sufficient addresses for the network's devices.

- **Exclusion Ranges:** Exclude specific IP addresses from the DHCP scope to reserve them for static assignment.

- **DHCP Options:** Configure DHCP options based on the network's DNS, router, and domain name requirements.

- **Lease Duration:** Adjust the lease duration based on the network's needs.

## Example Scenario

Suppose you want to set up a DHCP server for a subnet with the range 192.168.100.100 to 192.168.100.115. By following these steps, you can install, configure, and manage the DHCP server for the specified network.

## Note

This documentation provides a general guide for installing and configuring a DHCP server. Adjust the settings and options based on your specific network requirements and policies.
