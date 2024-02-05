## PowerShell Script for Moving AD Object
----
----

### Script Overview
This PowerShell script automates the process of moving an Active Directory security group (`sec-hr`) to a new Organizational Unit (OU) named `HR` within the existing `sweden-user` OU. The script utilizes the `Move-ADObject` cmdlet to perform this operation.

### Script Details

```powershell
# Moving the 'sec-hr' group to the 'HR' OU
Move-ADObject -Identity "CN=sec-hr,OU=sweden-user,DC=sweden,DC=se" -TargetPath "OU=HR,OU=sweden-user,DC=sweden,DC=se"
```

### Usage Instructions

1. **Run the Script:** Execute the script in a PowerShell environment.
2. **Review Active Directory:** Check Active Directory to verify that the `sec-hr` security group has been successfully moved to the `HR` OU within `sweden-user`.

### Considerations

- **Permissions:** Ensure that the account executing the script has the necessary permissions to move objects within Active Directory.
- **Target Path:** Adjust the `-TargetPath` parameter if you want to move the group to a different OU.
- **Verification:** After running the script, confirm the changes in Active Directory Users and Computers.

### Example Scenario

Suppose you have an existing Active Directory structure as follows:

```
- sweden-user
  - sec-hr (Security Group)
```

After running the script, the structure will be updated to:

```
- sweden-user
  - HR
    - sec-hr (Security Group)
```

### Note

This script is designed for moving a specific security group (`sec-hr`) to a predefined OU (`HR`) within the `sweden-user` container. Ensure you review and adjust security practices before deploying this script in a production environment.

Feel free to modify this document to include any additional details or instructions specific to your use case.
