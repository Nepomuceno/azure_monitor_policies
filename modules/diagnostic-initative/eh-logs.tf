resource "azurerm_eventhub_namespace" "base" {
  count                    = "${var.generate_eh ? length(var.locations) : 0}"
  name                     = "${var.prefix}-log-eh-ns-${element(var.locations,count.index)}"
  location                 = "${element(var.locations,count.index)}"
  resource_group_name      = "${azurerm_resource_group.base.*.name[count.index]}"
  sku                      = "Standard"
  capacity                 = 1
  kafka_enabled            = false
  auto_inflate_enabled     = true
  maximum_throughput_units = 5
}

resource "azurerm_eventhub_namespace_authorization_rule" "base" {
  count               = "${var.generate_eh ? length(var.locations) : 0}"
  name                = "${var.prefix}-log-eh-aut-${element(var.locations,count.index)}"
  namespace_name      = "${azurerm_eventhub_namespace.base.*.name[count.index]}"
  resource_group_name = "${azurerm_resource_group.base.*.name[count.index]}"

  listen = true
  send   = true
  manage = true
}

resource "azurerm_eventhub" "base" {
  count               = "${var.generate_eh ? length(var.locations) : 0}"
  name                = "${var.prefix}-log-eh-${element(var.locations,count.index)}"
  namespace_name      = "${azurerm_eventhub_namespace.base.*.name[count.index]}"
  resource_group_name = "${azurerm_resource_group.base.*.name[count.index]}"
  partition_count     = 5
  message_retention   = 1
}
