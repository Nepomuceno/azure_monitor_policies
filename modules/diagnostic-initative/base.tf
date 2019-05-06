resource "azurerm_resource_group" "base" {
  count    = "${length(var.locations)}"
  name     = "${var.rg_name}-${element(var.locations,count.index)}"
  location = "${element(var.locations,count.index)}"
}
