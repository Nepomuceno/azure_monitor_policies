"effect": "deployIfNotExists",
                "details": {
                    "type": "Microsoft.Compute/virtualMachines/extensions",
                    "name": ${deploy_name},
                    "roleDefinitionIds": [
                        ${role_definition}
                    ],
                    "existenceCondition": ${existence_condition},
                    "deployment": {
                        "properties": {
                            "mode": "incremental",
                            "parameters": ${deployment_parameters},
                            "template": ${deployment_template}
                        }
                    }
                }