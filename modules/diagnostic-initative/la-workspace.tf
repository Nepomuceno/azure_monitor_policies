resource "azurerm_log_analytics_workspace" "log_worspace" {
  count               = "${var.generate_la_worspace ? length(var.locations) : 0}"
  sku                 = "Standard"
  name                = "${var.prefix}-la-ws-${element(var.locations,count.index)}"
  location            = "${element(var.locations,count.index)}"
  resource_group_name = "${azurerm_resource_group.base.name}"
}
