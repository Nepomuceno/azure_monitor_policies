data "azurerm_subscription" "current" {}

resource "azurerm_policy_assignment" "enable_vms" {
  name                 = "auto-prov-diagnostic"
  scope                = "${data.azurerm_subscription.current.id}"
  policy_definition_id = "/providers/Microsoft.Authorization/policySetDefinitions/55f3eceb-5573-4f18-9695-226972c6d74a"
  description          = "Automatically provision vms"
  display_name         = "auto-prov-diagnostic"

  parameters = <<PARAMETERS
{
  "allowedLocations": {
    "value": [ "West Europe" ]
  }
}
PARAMETERS
}
