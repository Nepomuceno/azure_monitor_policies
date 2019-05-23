data "template_file" "parameters" {
  template = "${file("${path.module}/templates/policy_assignment_parameter.tpl")}"

  vars {
    storage_name          = "${var.storage_name}"
    eventhub_name         = "${var.eh_namespace}/${var.eh_name}"
    authorization_rule_id = "${azurerm_eventhub_namespace_authorization_rule.base.id}"
    location              = "${var.location}"
  }
}

resource "azurerm_policy_definition" "base" {
  count        = "${length(local.available)}"
  name         = "${var.prefix}-log-${element(local.available, count.index)}"
  policy_type  = "Custom"
  mode         = "All"
  display_name = "${var.prefix}-policy-${element(local.available, count.index)}"
  policy_rule  = "${file("${path.module}/policies/${element(local.available, count.index)}/rule.json")}"
  parameters   = "${file("${path.module}/policies/${element(local.available, count.index)}/parameters.json")}"
}

resource "azurerm_policy_assignment" "base" {
  count = "${length(local.available)}"
  name  = "${var.prefix}-policy-as-${element(local.available, count.index)}-${var.location}"

  #scope                = "/subscriptions/${data.azurerm_subscription.current.subscription_id}"
  scope                = "${var.scope}"
  policy_definition_id = "${azurerm_policy_definition.base.*.id[count.index]}"
  description          = "Policy to guarante deploy of logs if they do not exetis"
  display_name         = "${element(local.available, count.index)} - Log - ${var.location}"
  location             = "${var.location}"

  identity = {
    type = "SystemAssigned"
  }

  parameters = "${data.template_file.parameters.rendered}"
}

resource "azurerm_role_assignment" "assigment_rule_compatibility" {
  count                = "${length(local.available)}"
  scope                = "${var.scope}"
  role_definition_name = "Contributor"
  principal_id         = "${azurerm_policy_assignment.base.*.identity.0.principal_id[count.index]}"
}

output "roles" {
  value = "${azurerm_policy_assignment.base.*.identity}"
}

locals {
  available = ["eventhubs",
    "nsg",
    "loadbalancer",
    "publicip",
    "virtualnetwork",
    "applicationgateway",
    "securegateways",
    "applicationfirewall",
    "gateway",
    "traficmanager",
    "gateway",
    "expressroute",
    "frontdoor",
    "powerbi",
    "backupvault",
    "search",
    "servicebus",
  ]
}
