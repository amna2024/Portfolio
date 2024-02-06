# PowerShell Script for Invoking Azure Automation Webhook

This PowerShell script is used to invoke an Azure Automation webhook using the `Invoke-WebRequest` cmdlet.

## Invoke Azure Automation Webhook

```powershell
# Define the Azure Automation webhook URL
$url = 'https://5ecc04b7-169c-4137-a2c9-ba352852dabd.webhook.sec.azure-automation.net/webhooks?token=QbPAPr2ziz4S2sRvi8NDEIomXK61MhclCdnzkG3Ql4o%3d'

# Define data to be sent in the request body
$Data = @{
    RG = "testrg01"
    LO = "swedencentral"
}

# Convert data to JSON format
$body = ConvertTo-Json -InputObject $Data

# Invoke the Azure Automation webhook
$response = Invoke-WebRequest -Method Post -Uri $url -Body $body -UseBasicParsing

# Display the response
$response
```

Ensure to replace the `$url` variable with the actual URL of your Azure Automation webhook. Modify the `$Data` variable to include the required parameters for your webhook.

This script sends a POST request to the Azure Automation webhook URL with the specified data in JSON format.
```

Adjust the webhook URL and data parameters as needed before running the script.
