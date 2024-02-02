# Server Virtualization
----------
## Part 1: Setting Up Remote Desktop Services (RDS)

### Step 1: AD Server Configuration
- AD Server (AD01):
  - Computer Name: AD01
  - Domain: mstile.com
  - IP Address: 192.168.100.10
  - Roles and Features:
    1. Install AD, DHCP, and DNS roles.
    2. Import user data from CSV file.
    3. Create OUs and security groups.
    4. Configure GPO for Folder Redirection:
       - Desktop
       - Documents
       - Pictures
       - Network folder G:\Gemensam for all users

### Step 2: Server 2019 (RDS01)
- Computer Name: RDS01
- Domain: mstile.com
- IP Address: 192.168.100.11
- DNS: 192.168.100.10
- Roles and Features:
  1. Install Remote Desktop role.
  2. Configure RD Web Access, RD Connection Broker, and RD Session Host.
  3. Set up a collection.
  4. Access [https://rds01.mstile.se/rdweb](https://rds01.mstile.se/rdweb), start applications, and verify Folder Redirection.

#### Quick Solution Overview
- **AD Server Configuration Steps:**
  1. Install AD, DHCP, and DNS roles.
  2. Import user data from CSV file.
  3. Create OUs and security groups.
  4. Configure GPO for Folder Redirection.

- **RDS Server Configuration Steps:**
  1. Install Remote Desktop role.

... (Continued for Windows 10, PFsense, RD Gateway, and Remote App)

## Part 2: Enabling Remote Access

### PFsense Configuration
1. Configure PFsense WAN settings.
2. Disable Reserved Networks.
3. Set up NAT and port forward for HTTPS to RDS01.
4. Update host file on the physical computer for RDS access.

### RD Gateway and Certificate Configuration
1. Install PFsense or Windows Server 2019 with Windows Routing service.
2. Install RDS Gateway role on RDS01.
3. Configure RDS Gateway with a certificate.
4. Copy and install the certificate on the client machine.
5. Test remote access via [https://rds01.mstile.se/rdweb](https://rds01.mstile.se/rdweb).

...

## Part 3: Implementing Remote App

### Remote App Configuration
1. Go to RDS01 Collections.
2. Select a program and publish it as a Remote App.
3. Test user login on the RDS01 webpage and launch the application.

## Topology Diagram

![Topology Diagram](image_prefix-001.jpg)

**Note:** Adjust the image references and paths according to your extracted images.

