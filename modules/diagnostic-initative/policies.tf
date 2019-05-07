data "template_file" "parameters" {
  count    = "${length(var.locations)}"
  template = "${file("${path.module}/templates/policy_assignment_parameter.tpl")}"

  vars {
    storage_name          = "${var.storage_id}"
    eventhub_name         = "${azurerm_eventhub_namespace.base.*.name[count.index]}"
    authorization_rule_id = "${azurerm_eventhub_namespace_authorization_rule.base.*.id[count.index]}"
    location              = "${element(var.locations, count.index)}"
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
  count = "${length(local.available) * length(var.locations)}"
  name  = "${var.prefix}-policy-as-${element(local.available, count.index % length(local.available))}-${element(var.locations, count.index % length(var.locations))}"

  #scope                = "/subscriptions/${data.azurerm_subscription.current.subscription_id}"
  scope                = "${var.scope}"
  policy_definition_id = "${azurerm_policy_definition.base.*.id[count.index % length(local.available)]}"
  description          = "Policy to guarante deploy of logs if they do not exetis"
  display_name         = "${element(local.available, count.index % length(local.available))} - Enable Log - ${element(var.locations, count.index % length(var.locations))}"
  location             = "${element(var.locations, count.index % length(var.locations))}"

  identity = {
    type = "SystemAssigned"
  }

  parameters = "${data.template_file.parameters.*.rendered[count.index % length(var.locations)]}"
}

resource "azurerm_role_assignment" "assigment_rule_compatibility" {
  count                = "${length(local.available) * length(var.locations)}"
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
