# Linux diagnostics automatically isntall policy

This is a terraform module that will create a [policy](https://docs.microsoft.com/en-us/azure/governance/policy/overview) to automatically install [Diagnostic Agent](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/diagnostics-extension-overview).

This policy does use the `DeployifNotExist` effect of the policy.

