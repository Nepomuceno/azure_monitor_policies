resource "random_id" "server" {
  keepers = {
    prefix = "${var.prefix}"
  }

  byte_length = 4
}

/*
resource "azurerm_virtual_machine_extension" "omsLogs" {
  location             = "${var.location}"
  name                 = "${var.prefix}-oms-ext"
  resource_group_name  = "${var.resource_group_name}"
  type                 = "OmsAgentForLinux"
  publisher            = "Microsoft.EnterpriseCloud.Monitoring"
  type_handler_version = "1.9.1"
  protected_settings   = "${local.private_config}"
  settings             = "${local.private_config}"
  virtual_machine_name = "oms-Extension"
}
*/

