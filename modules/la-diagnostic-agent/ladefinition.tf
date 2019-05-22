data "azurerm_subscription" "current" {}

resource "azurerm_policy_definition" "base" {
  name         = "${var.prefix}-la-log"
  policy_type  = "Custom"
  mode         = "All"
  display_name = "${var.prefix}-policy-la"
  policy_rule  = "${local.base_policy}"
  parameters   = "${local.parameters}"
}


resource "azurerm_policy_assignment" "force_diagnostic" {
  name                 = "${var.prefix}-oms-logs"
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
}
PARAMETERS
}

resource "azurerm_role_assignment" "assigment_rule_compatibility" {
  scope                = "${data.azurerm_subscription.current.id}"
  role_definition_name = "Contributor"
  principal_id         = "${azurerm_policy_assignment.force_diagnostic.identity.0.principal_id}"
}

locals {
  parameters = <<POLICY_RULE_TEMPLATE
{
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
