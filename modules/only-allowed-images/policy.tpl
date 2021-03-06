{
  "properties": {
    "displayName": "Allowed locations",
    "policyType": "BuiltIn",
    "mode": "Indexed",
    "description": "This policy enables you to restrict the locations your organization can specify when deploying resources. Use to enforce your geo-compliance requirements. Excludes resource groups, Microsoft.AzureActiveDirectory/b2cDirectories, and resources that use the 'global' region.",
    "metadata": {
      "category": "General"
    },
    "parameters": {
      "listOfAllowedLocations": {
        "type": "Array",
        "metadata": {
          "description": "The list of locations that can be specified when deploying resources.",
          "strongType": "location",
          "displayName": "Allowed locations"
        }
      },
      "listOfImageIdToInclude": {
        "type": "Array",
        "metadata": {
          "displayName": "Optional: List of VM images that have supported Linux OS to add to scope",
          "description": "Example value: '/subscriptions/<subscriptionId>/resourceGroups/YourResourceGroup/providers/Microsoft.Compute/images/ContosoStdImage'"
        },
        "defaultValue": []
      }
    },
    "policyRule": {
      "if": {
        "allOf": [
          {
            "field": "type",
            "equals": "Microsoft.Compute/virtualMachineScaleSets"
          },
          {
            "not": {
              "anyOf": [
                {
                  "field": "Microsoft.Compute/imageId",
                  "in": "[parameters('listOfImageIdToInclude')]"
                },
                {
                  "field": "Microsoft.Compute/imagePublisher",
                  "in": [
                    "microsoft-aks",
                    "AzureDatabricks",
                    "datastax",
                    "couchbase",
                    "scalegrid",
                    "checkpoint",
                    "paloaltonetworks"
                  ]
                },
                {
                  "allOf": [
                    {
                      "field": "Microsoft.Compute/imagePublisher",
                      "equals": "OpenLogic"
                    },
                    {
                      "field": "Microsoft.Compute/imageOffer",
                      "like": "CentOS*"
                    },
                    {
                      "field": "Microsoft.Compute/imageSKU",
                      "notLike": "6*"
                    }
                  ]
                }
              ]
            }
          }
        ]
      },
      "then": {
        "effect": "deny"
      }
    }
  },
  "type": "Microsoft.Authorization/policyDefinitions",
  "name": "Only-Allow-Specific-VM-IMages"
}
