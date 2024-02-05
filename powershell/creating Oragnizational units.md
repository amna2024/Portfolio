# Script Overview

## Purpose
This script automates the creation of Organizational Units (OUs), user accounts, sub-OUs, and security groups in Active Directory for the "bstile" domain.

## Script Components

### Creating OUs
- **bstile-user OU:** Organizational Unit for user accounts.

### Creating User Accounts
- Reads user information from a CSV file.
- Creates user accounts in the "bstile-user" OU with specified properties:
  - Display name, given name, surname, SAM account name, and user principal name.
  - Uses a common password ("Amna1234") for all user accounts.
  - Password not required for simplicity (adjust based on security policies).

### Creating Sub-OUs
- **ekonomi:** Sub-OU for the finance department.
- **HR:** Sub-OU for the human resources department.
- **Marknad:** Sub-OU for the marketing department.

### Creating Security Groups
- **sec-hr:** Security group for HR department.
- **sec-Ekonomi:** Security group for the finance department.
- **sec-Marknad:** Security group for the marketing department.

### Adding Group Members
- Adds members to the created security groups for each department.

## Usage
1. Run the script in a PowerShell environment.
2. Review Active Directory to verify the creation of OUs, user accounts, sub-OUs, and security groups.

## Script Execution
Ensure that the script is executed with appropriate permissions and on a machine connected to the "bstile" domain.

**Note:** Always review and adjust security practices before deploying scripts in a production environment.
