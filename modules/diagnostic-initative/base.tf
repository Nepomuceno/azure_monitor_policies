resource "azurerm_resource_group" "base" {
  name     = "${var.rg_name}"
  location = "${var.location}"
}
