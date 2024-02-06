{
    "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
    "contentVersion": "1.0.0.0",
    "parameters": {

    "storageAccountsname":{
        "type": "string",
         "defaultValue": "mov2022storageacc1"
            },
        
        "plats": {
            "type": "string",
            "defaultValue": "[resourceGroup().location]"
            },
            "nsgname":{
                "type": "string",
                "defaultValue": "mov22nsg01"
            },
        "securityRulesParameter": {
            "type": "array",
            "defaultValue": [
                {
                "name": "AllowRdp",
                "properties": {
                    "priority": 100,
                    "protocol": "Tcp",
                    "access": "Allow",
                    "direction": "Inbound",
                    "sourceAddressPrefix": "*",
                    "sourcePortRange": "*",
                    "destinationAddressPrefix": "*",
                    "destinationPortRange": "3389"
                }
                }
            ]
            },
          
            "vnetname": {
                   "type": "string",
                "defaultValue": "mov2022vnet01"
            },
           
               "publicipname": {
                   "type": "string",
                "defaultValue": "mov2022VMPublicIP"
            },
            "niccname":{
                "type": "string",
                "defaultValue":"mov2022nic01"
            },
            "VMname":{
                "type": "string",
                "defaultValue":"MOVVM1"
            }
                        
        

          
    }, 

    "functions": [],
    "variables": {},
    "resources": [
        //storage
        { 
            "name": "[parameters('storageAccountsname')]",
            "type": "Microsoft.Storage/storageAccounts",
            "apiVersion": "2023-01-01",
            "tags": {
                "displayName": "[parameters('storageAccountsname')]"
            },
            "location": "[parameters('plats')]",
            "kind": "StorageV2",
            "sku": {
                "name": "Standard_LRS",
                "tier": "Standard"
            }
        },

              //Create NSG and rule
        {
            "name": "[parameters('nsgname')]",
            "type": "Microsoft.Network/networkSecurityGroups",
            "apiVersion": "2020-11-01",
            "location":"[parameters('plats')]",
            "properties": {
                "securityRules": "[parameters('securityRulesParameter')]"
            }
        },
          //ip
        {
             "name": "[parameters('vnetname')]",
            "type": "Microsoft.Network/virtualNetworks",
            "apiVersion": "2020-11-01",
            "location":"[parameters('plats')]",
            "tags": {
                "displayName": "[parameters('vnetname')]"
            },
            "properties": {
                "addressSpace": {
                    "addressPrefixes": [
                        "10.0.0.0/16"
                    ]
                },
                "subnets": [
                    {
                        "name": "Subnet-1",
                        "properties": {
                            "addressPrefix": "10.0.1.0/24",
                            "networkSecurityGroup": {
                                "id": "[resourceId('Microsoft.Network/networkSecurityGroups',parameters('nsgname'))]"

                            }
                        }
                    },
                    {
                        "name": "Subnet-2",
                        "properties": {
                            "addressPrefix": "10.0.2.0/24"
                        }
                    }
                ]
            }
        },
          
        //Create Public IP
        {
            "name":"[parameters('publicipname')]" ,
            "type": "Microsoft.Network/publicIPAddresses",
            "apiVersion": "2020-11-01",
            "location": "[parameters('plats')]",
            "tags": {
                "displayName":"[parameters('publicipname')]"
            },
            "properties": {
                "publicIPAllocationMethod": "Dynamic",
                "dnsSettings": {
                    "domainNameLabel": "[toLower('MOVVM1')]"
                }

            }
        },
        //Create NIC
        {
            "name": "[parameters('niccname')]",
            "type": "Microsoft.Network/networkInterfaces",
            "apiVersion": "2020-11-01",
            "location": "[parameters('plats')]",
            "tags": {
                "displayName": "[parameters('niccname')]"
            },
            "dependsOn": [
                "[resourceId('Microsoft.Network/virtualNetworks', parameters('vnetname'))]"
            ],
            "properties": {
                "ipConfigurations": [
                    {
                        "name": "movipConfig1",
                        "properties": {
                            "privateIPAllocationMethod": "Dynamic",
                            "subnet": {
                                "id": "[resourceId('Microsoft.Network/virtualNetworks/subnets', parameters('vnetname'), 'Subnet-1')]"
                            },
                            "publicIPAddress": {

                                "id": "[resourceId('Microsoft.Network/publicIPAddresses',parameters('publicipname') )]"

                            }
                        
                        }
                        
                    }
                ]
            }
        },
        //Create VM
        {
            "name": "[parameters('VMname')]",
            "type": "Microsoft.Compute/virtualMachines",
            "apiVersion": "2021-03-01",
           "location": "[parameters('plats')]",
            "dependsOn": [
                "[resourceId('Microsoft.Storage/storageAccounts', toLower('mov2022storageacc1'))]",
                "[resourceId('Microsoft.Network/networkInterfaces', 'mov2022nic01')]"
            ],
            "tags": {
                "displayName":"[parameters('VMname')]"
            },
            "properties": {
                "hardwareProfile": {
                    "vmSize": "Standard_A2_v2"
                },
               
            "tags": {
                "displayName": "MOVVM1"
            },
            "properties": {
                "hardwareProfile": {
                    "vmSize": "Standard_A2_v2"
                },
                "osProfile": {
                    "computerName": "MOVVM1",
                    "adminUsername": "typitadmin",
                    "adminPassword": "Sommar202020!"
                },
                "storageProfile": {
                    "imageReference": {
                        "publisher": "MicrosoftWindowsServer",
                        "offer": "WindowsServer",
                        "sku": "2022-Datacenter",
                        "version": "latest"
                    },
                    "osDisk": {
                        "name": "windowsVM1OSDisk",
                        "caching": "ReadWrite",
                        "createOption": "FromImage"
                    }
                
                },
                "diagnosticsProfile": {
                    "bootDiagnostics": {
                        "enabled": true,
                        "storageUri": "[reference(resourceId('Microsoft.Storage/storageAccounts/', toLower('mov2022storageacc1'))).primaryEndpoints.blob]"
                    }
                }
            }
        


        
    
    

                     
                              
                       
                        
            }
            }   

    ],

    "outputs": {}
} 
