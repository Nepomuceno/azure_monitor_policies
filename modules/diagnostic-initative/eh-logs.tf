resource "azurerm_eventhub_namespace_authorization_rule" "base" {
  name                = "${var.prefix}log-eh-aut-${var.location}"
  namespace_name      = "${var.eh_namespace}"
  resource_group_name = "${var.rg_name}"

  listen = true
  send   = true
  manage = true
}
