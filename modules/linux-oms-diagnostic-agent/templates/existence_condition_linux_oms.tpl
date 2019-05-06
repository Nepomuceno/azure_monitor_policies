{
    "allOf": [
        {
            "field": "Microsoft.Compute/virtualMachines/extensions/type",
            "equals": "OmsAgentForLinux"
        },
        {
            "field": "Microsoft.Compute/virtualMachines/extensions/publisher",
            "equals": "Microsoft.EnterpriseCloud.Monitoring"
        },
        {
            "field": "Microsoft.Compute/virtualMachines/extensions/provisioningState",
            "equals": "Succeeded"
        }
    ]
}