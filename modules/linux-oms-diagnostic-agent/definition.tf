data "azurerm_subscription" "current" {}

resource "azurerm_policy_definition" "base" {
  name         = "${var.prefix}-log-oms"
  policy_type  = "Custom"
  mode         = "All"
  display_name = "${var.prefix}-policy-oms"
  policy_rule  = "${local.base_policy}"
  parameters   = "${local.parameters}"
}

resource "azurerm_policy_assignment" "force_diagnostic" {
  name                 = "${var.prefix}-force-logs"
  scope                = "${data.azurerm_subscription.current.id}"
  policy_definition_id = "${azurerm_policy_definition.base.id}"
  description          = "Enforce that Linux vms do have diagnostics enable"
  display_name         = "Enforce LA Linux"
  location             = "${var.location}"

  identity = {
    type = "SystemAssigned"
  }

  parameters = <<PARAMETERS
{
  "workspaceId": {
    "value": "${var.workspaceId}"
  },
  "workspaceKey": {
    "value": "${var.workspaceKey}"
  }
}
PARAMETERS
}

locals {
  parameters = <<POLICY_RULE_TEMPLATE
{
      "workspaceId": {
        "type": "String",
        "metadata": {
          "displayName": "Log Analytics workspace",
        }
      },
      "workspaceKey": {
        "type": "String",
        "metadata": {
          "displayName": "Log Analytics workspace",
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
    }
POLICY_RULE_TEMPLATE

  available = true
}
