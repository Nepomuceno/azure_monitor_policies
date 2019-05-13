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
  storage_sas_key = "7523wzlce7IuTU3e/TocIIeDLPoiphhSbpQdX/ZkzQ8%3D"
  eh_sas_url      = "https://test-auto-prov.servicebus.windows.net/sample?sr=https%3A%2F%2Ftest-auto-prov.servicebus.windows.net%2Fsample&sig=VT6bLGi0c1eMPgD52JnXAoyMhMLp3a2y7LkcXR2m/E4%3D&se=1617752016&skn=sender"
  storage_name    = "samplepolicy"
}

module "monitor" {
  source       = "./monitor"
  oms_worspace = "bla"
}
