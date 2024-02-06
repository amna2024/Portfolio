# PowerShell Script Documentation

This PowerShell script performs various tasks related to retrieving and manipulating information about services in Windows.

## Tasks Handled:

1. **Get All Services in Windows:**
   - Retrieves a list of all services running on the Windows system.

2. **Get Display Names of All Services:**
   - Retrieves the display names of all services running on the Windows system.

3. **Export All Services to a Text File:**
   - Retrieves all services and exports the information to a text file located at `C:\powershell\new.txt`, including the display name and status of each service.

4. **Filter Running Services:**
   - Filters and displays only the services that are currently running.

5. **Export Stopped Services to a Text File:**
   - Filters the stopped services and exports the display name and status of each stopped service to a text file.

6. **List Files and Folders in the PowerShell Directory:**
   - Lists all files and folders under the `C:\powershell` directory.

## Notes:
- The script utilizes various PowerShell cmdlets such as `Get-Service`, `Select-Object`, `Where-Object`, `Out-File`, and `Get-ChildItem` to perform the tasks mentioned above.
- Each task is documented with a brief description to explain its purpose and functionality.
- The script demonstrates how to interact with services in Windows and manipulate their information using PowerShell commands.

This documentation provides an overview of the script's functionality and helps users understand its purpose and the tasks it performs.
