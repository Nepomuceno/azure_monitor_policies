data "azurerm_subscription" "current" {}

module "test_module" {
  source               = "./diagnostic-initative"
  prefix               = "test-policy"
  scope                = "${data.azurerm_subscription.current.id}"
  rg_name              = "test-policy-log"
  generate_la_worspace = false
  locations            = ["uksouth", "ukwest", "westeurope"]
}

module "test_linux" {
  source        = "./linux-oms-diagnostic-agent"
  workspaceId   = "219d585f-0252-4fee-a140-8915825d6742"
  workspaceKey  = "ERexNBFqKwOh+Uqh3GtXMy0OyMu5fwSOfAEINWLyoDTh0LrDrzQWwC8P4GEh+tH/ao0xjdW3efhiHWSxC5Pvtg=="
  workspaceName = "test-log-demo"
  prefix        = "oms-deploy"
  location      = "UK South"
}
