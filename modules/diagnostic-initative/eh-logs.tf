resource "azurerm_eventhub_namespace" "base" {
  count                    = "${var.generate_eh}"
  name                     = "${var.prefix}-log-eh-ns"
  location                 = "${var.location}"
  resource_group_name      = "${azurerm_resource_group.base.name}"
  sku                      = "Standard"
  capacity                 = 1
  kafka_enabled            = false
  auto_inflate_enabled     = true
  maximum_throughput_units = 5
}

resource "azurerm_eventhub_namespace_authorization_rule" "base" {
  count               = "${var.generate_eh}"
  name                = "${var.prefix}-log-eh-aut"
  namespace_name      = "${azurerm_eventhub_namespace.base.name}"
  resource_group_name = "${azurerm_resource_group.base.name}"

  listen = false
  send   = true
  manage = true
}

resource "azurerm_eventhub" "base" {
  count               = "${var.generate_eh}"
  name                = "${var.prefix}-log-eh"
  namespace_name      = "${azurerm_eventhub_namespace.base.name}"
  resource_group_name = "${azurerm_resource_group.base.name}"
  partition_count     = 5
  message_retention   = 1
}
