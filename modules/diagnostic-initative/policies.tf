resource "azurerm_policy_definition" "base" {
  count        = "${length(local.available)}"
  name         = "${var.prefix}-log-${element(local.available, count.index)}"
  policy_type  = "Custom"
  mode         = "All"
  display_name = "${var.prefix}-policy-${element(local.available, count.index)}-${count.index}"
  policy_rule  = "${file("${path.module}/policies/${element(local.available, count.index)}/rule.json")}"
  parameters   = "${file("${path.module}/policies/${element(local.available, count.index)}/parameters.json")}"
}

resource "azurerm_policy_assignment" "base" {
  count = "${length(local.available)}"
  name  = "${var.prefix}-policy-as-${element(local.available, count.index)}"

  #scope                = "/subscriptions/${data.azurerm_subscription.current.subscription_id}"
  scope                = "${var.scope}"
  policy_definition_id = "${azurerm_policy_definition.base.*.id[count.index]}"
  description          = "Policy to guarante deploy of logs if they do not exetis"
  display_name         = "Resource Creation"
  location             = "${var.location}"

  identity = {
    type = "SystemAssigned"
  }

  parameters = <<PARAMETERS
{
  "storageAccountName": {
    "value": "${azurerm_storage_account.log_storage.name}"
  }
  "eventHubName": {
    "value": "${azurerm_eventhub_namespace.base.}"
  }
  "eventHubAuthorizationRuleId": {
    "value": "${}"
  }

}
PARAMETERS
}

locals {
  available = [
    "eventhubs",
  ]
}
