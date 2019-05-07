{
    "allOf": [
        {
            "field": "Microsoft.Compute/virtualMachines/extensions/type",
            "equals": "LinuxDiagnostic"
        },
        {
            "field": "Microsoft.Compute/virtualMachines/extensions/publisher",
            "equals": "Microsoft.Azure.Diagnostics"
        },
        {
            "field": "Microsoft.Compute/virtualMachines/extensions/provisioningState",
            "equals": "Succeeded"
        }
    ]
}