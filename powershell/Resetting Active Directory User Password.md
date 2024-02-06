# PowerShell Script for Resetting Active Directory User Password

This PowerShell script is designed to reset the password for an Active Directory user account specified by its distinguished name (DN).

## Reset User Password

```powershell
# Reset password for Active Directory user account
Set-ADAccountPassword -Identity 'CN=Elisa Daugherty,OU=Accounts,DC=Fabrikam,DC=com' `
    -Reset -NewPassword (ConvertTo-SecureString -AsPlainText "p@ssw0rd" -Force)
```

Ensure to replace the placeholder `'CN=Elisa Daugherty,OU=Accounts,DC=Fabrikam,DC=com'` with the actual distinguished name (DN) of the user account for which you want to reset the password. Also, modify the new password (`"p@ssw0rd"`) as per your organization's password policy.

Make sure to run this script with appropriate permissions and review the parameters before execution.
```

Adjust the distinguished name and new password as needed before running the script.
