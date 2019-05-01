data "azurerm_subscription" "current" {}

module "test_module" {
  source               = "./diagnostic-initative"
  location             = "UK South"
  prefix               = "test-policy"
  scope                = "${data.azurerm_subscription.current.id}"
  rg_name              = "test-policy-log"
  generate_la_worspace = false
}
