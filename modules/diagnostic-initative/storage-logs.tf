resource "random_id" "server" {
  keepers = {
    prefix = "${var.prefix}"
  }

  byte_length = 4
}

resource "azurerm_storage_account" "log_storage" {
  name                     = "${replace(var.prefix,"[-_]*","")}logst${random_id.server.dec}"
  location                 = "${var.location}"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
  account_tier             = "Standard"
  resource_group_name      = "${azurerm_resource_group.base.name}"
}
