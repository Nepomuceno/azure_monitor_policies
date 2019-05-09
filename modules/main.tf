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
  source       = "./oms-log-agent"
  workspaceId  = "219d585f-0252-4fee-a140-8915825d6742"
  workspaceKey = "ERexNBFqKwOh+Uqh3GtXMy0OyMu5fwSOfAEINWLyoDTh0LrDrzQWwC8P4GEh+tH/ao0xjdW3efhiHWSxC5Pvtg=="
  prefix       = "oms-deploy"
  location     = "uksouth"
}

module "test_diagnostic" {
  source          = "./la-diagnostic-agent"
  prefix          = "la-deploy"
  location        = "uksouth"
  storage_sas_key = ""
  eh_sas_url      = ""
  storage_name    = ""
}

module "monitor" {
  source       = "./monitor"
  oms_worspace = "bla"
}
