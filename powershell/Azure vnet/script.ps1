{
    "vnetrules": "[parameters('vnetrules')]",
    "subnets": [
        {
            "name": "Subnet-1",
            "properties": {
                "addressPrefix": "10.0.1.0/24",
                "networkSecurityGroup": {
                    "id": "[resourceId('Microsoft.Network/networkSecurityGroups','mov2022nsg01')]"  #change the id upto your azure id 
                }
            }
        },
        {
            "name": "Subnet-2",
            "properties": {
                "addressPrefix": "10.0.2.0/24"
            }
        }
    ],
    "vnetrules": {
        "type": "array",
        "defaultValue": [
            {
                "properties": {
                    "addressspace": {
                        "addressPrefixes": "10.0.0.0/16"
                    }
                }
            }
        ]
    }
}
