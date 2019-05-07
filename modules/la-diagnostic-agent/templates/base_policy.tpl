{
            "if": {
                "allOf": [
                    {
                        "field": "type",
                        "equals": "Microsoft.Compute/virtualMachines"
                    },
                    {
                        "anyOf": ${os_definition}
                    }
                ]
            },
            "then": {
                ${effect}
            }
}