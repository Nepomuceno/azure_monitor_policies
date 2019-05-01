resource "azurerm_log_analytics_workspace" "log_worspace" {
  count               = "${var.generate_la_worspace}"
  sku                 = "Standard"
  name                = "${var.prefix}-la-ws"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.base.name}"
}
