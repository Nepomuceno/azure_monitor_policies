{
                "$schema": "http://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#",
                "contentVersion": "1.0.0.0",
                "parameters": {
                  "vmName": {
                    "type": "string"
                  },
                  "location": {
                    "type": "string"
                  },
                  "workspaceId": {
                    "type": "string"
                  },
                  "workspaceKey": {
                    "type": "string"
                  }
                },
                "variables": {
                  "vmExtensionName": "MMAExtension",
                  "vmExtensionPublisher": "Microsoft.EnterpriseCloud.Monitoring",
                  "vmExtensionType": "OmsAgentForLinux",
                  "vmExtensionTypeHandlerVersion": "${version}"
                },
                "resources": [
                  {
                    "name": "[concat(parameters('vmName'), '/', variables('vmExtensionName'))]",
                    "type": "Microsoft.Compute/virtualMachines/extensions",
                    "location": "[parameters('location')]",
                    "apiVersion": "2018-06-01",
                    "properties": {
                      "publisher": "[variables('vmExtensionPublisher')]",
                      "type": "[variables('vmExtensionType')]",
                      "typeHandlerVersion": "[variables('vmExtensionTypeHandlerVersion')]",
                      "autoUpgradeMinorVersion": true,
                      "settings": {
                        "workspaceId": "[parameters('workspaceId')]",
                        "stopOnMultipleConnections": "true"
                      },
                      "protectedSettings": {
                        "workspaceKey": "[parameters('workspaceKey')]"
                      }
                    }
                  }
                ],
                "outputs": {
                  "policy": {
                    "type": "string",
                    "value": "[concat('Enabled extension for VM', ': ', parameters('vmName'))]"
                  }
                }
              }