# Configure the Azure Provider
provider "azurerm" {
  # whilst the `version` attribute is optional, we recommend pinning to a given version of the Provider
  version = "=1.24.0"
}

data "azurerm_subscription" "current" {}

data "azurerm_role_definition" "Contributor" {
  name = "Contributor"
}

resource "random_uuid" "provider" { }

resource "azurerm_resource_group" "sample" {
  name     = "${var.prefix}-policies"
  location = "${var.location}"
}

resource "azurerm_storage_account" "sample" {
  name                     = "${var.prefix}logs"
  resource_group_name      = "${azurerm_resource_group.sample.name}"
  location                 = "${var.location}"
  account_tier             = "Standard"
  account_replication_type = "GRS"
  account_kind             = "StorageV2"
}

resource "azurerm_policy_definition" "sample" {
  name         = "${var.prefix}-rule-0"
  policy_type  = "Custom"
  mode         = "All"
  display_name = "${var.prefix}-policy-${var.resource}-0"
  policy_rule  = "${file("${path.module}/policies/${var.resource}/rule.json")}"
  parameters   = "${file("${path.module}/policies/${var.resource}/parameters.json")}"
}

resource "azurerm_policy_assignment" "sample" {
  name = "example-policy-assignment"

  #scope                = "/subscriptions/${data.azurerm_subscription.current.subscription_id}"
  scope                = "${azurerm_resource_group.sample.id}"
  policy_definition_id = "${azurerm_policy_definition.sample.id}"
  description          = "Sample Policy to demonstrate deploy if do not exetis"
  display_name         = "Resource Creation"
  location             = "${var.location}"

  identity = {
    type = "SystemAssigned"
  }

  parameters = <<PARAMETERS
{
  "storageAccountName": {
    "value": "${azurerm_storage_account.sample.name}"
  }
}
PARAMETERS
}

output "subscription_id" {
  value = "${data.azurerm_subscription.current.subscription_id}"
}

output "subscription_name" {
  value = "${data.azurerm_subscription.current.display_name}"
}

variable "location" {
  default = "UK South"
}

variable "prefix" {
  default = "terraformtest"
}

variable "requiredRetentionDays" {
  default = 365
}

variable "resource" {
  default = "eventhubs"
}
