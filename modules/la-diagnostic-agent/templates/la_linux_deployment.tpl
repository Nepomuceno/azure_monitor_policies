{
                "$schema": "http://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#",
                "contentVersion": "1.0.0.0",
                "parameters": {
                  "vmName": {
                    "type": "string"
                  },
                  "location": {
                    "type": "string"
                  }
                },
                "variables": {
                  "vmExtensionName": "policyDeployedAgent",
                  "vmExtensionPublisher": "Microsoft.Azure.Diagnostics",
                  "vmExtensionType": "LinuxDiagnostic",
                  "vmExtensionTypeHandlerVersion": "${version}",
                  "pre-resource-id": "${preresource}",
                  "post-resource-id": "${postresource}",
                  "resource-id": "[resourceId('Microsoft.Compute/virtualMachines',parameters('vmName'))]",
                  "settings": "[concat(variables('pre-resource-id'),variables('resource-id'),variables('post-resource-id'))]",
                  "parsed_settings": "[json(variables('settings'))]",
                  "parsed_protected": "[json('${protected_settings}')]"
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
                      "settings": "[variables('parsed_settings')]",
                      "protectedSettings": "[variables('parsed_protected')]"
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