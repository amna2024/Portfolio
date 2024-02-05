# ReadMe: Windows 11 Pro Server Configuration Script

## Overview

This PowerShell script automates the setup and configuration of a Windows 11 Pro virtual machine (VM) named "PR ad." The script is designed for tasks related to VM creation, network configuration, Active Directory (AD) setup, organizational unit (OU) creation, user import, group creation, and folder sharing. The script leverages Sysprep for the creation of virtual hard disks.

## Prerequisites

- Ensure PowerShell is installed and execution policy is set appropriately.
- Hyper-V feature should be enabled on the host machine.
- Active Directory module should be available on the VM.

## Usage

1. **Virtual Machine Setup:**
   - Run the script to create and configure the VM.
   - Adjust variables like `$VName` for VM naming.

   ```powershell
   .\Windows11Pro_Configuration.ps1
   ```

2. **Network Configuration:**
   - Script configures IP address and DNS settings.

3. **Active Directory Configuration:**
   - AD Forest is set up with specified domain details.

4. **OU and Group Creation:**
   - OUs like "sweden-user" and security groups are created.

5. **User Import:**
   - Users are imported from a CSV file.

6. **Folder Sharing:**
   - Shared folders like "SharedFolder," "SharedFolder\gemensem," and "SharedFolder\a" are created.

## Important Notes

- The script uses Sysprep for creating virtual hard disks.
- Ensure proper credentials and paths are set for CSV import.
- Adjust script parameters as needed for your environment.

## Acknowledgments

This script is provided as-is and might require adjustments based on specific use cases. Please review and modify the script as necessary for your environment and security considerations.

**Note:** This script was generated based on user-provided information, and it's recommended to review and test thoroughly in a controlled environment before deploying it in a production setting.
