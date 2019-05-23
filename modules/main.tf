data "azurerm_subscription" "current" {}

resource "azurerm_resource_group" "test" {
  name     = "test-policy-log"
  location = "uksouth"
}

resource "azurerm_storage_account" "testsa" {
  name                     = "azlogtestvalidatestore"
  resource_group_name      = "test-policy-log"
  location                 = "uksouth"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

/*
resource "azurerm_eventhub_namespace" "test" {
  name                = "ehlogtest"
  location            = "uksouth"
  resource_group_name = "test-policy-log"
  sku                 = "Standard"
  capacity            = 1
  kafka_enabled       = false
}

resource "azurerm_eventhub" "test" {
  name                = "ehlogtestsample"
  namespace_name      = "ehlogtest"
  resource_group_name = "test-policy-log"
  partition_count     = 5
  message_retention   = 7
}


module "test_module" {
  source       = "./diagnostic-initative"
  prefix       = "test"
  scope        = "${data.azurerm_subscription.current.id}"
  rg_name      = "test-policy-log"
  location     = "uksouth"
  eh_namespace = "ehlogtest"
  eh_name      = "ehlogtestsample"
  storage_name = "azlogtestvalidatestore"
}
*/

resource "azurerm_app_service_plan" "csmrg" {
  name                = "sp-amf-dev"
  location            = "${azurerm_resource_group.test.location}"
  resource_group_name = "${azurerm_resource_group.test.name}"

  sku {
    tier = "PremiumV2"
    size = "P1v2"
  }
}

resource "azurerm_function_app" "splunk_proxy" {
  name                      = "gabrielasppxdev"
  location                  = "${azurerm_resource_group.test.location}"
  resource_group_name       = "${azurerm_resource_group.test.name}"
  app_service_plan_id       = "${azurerm_app_service_plan.csmrg.id}"
  storage_connection_string = "${azurerm_storage_account.testsa.primary_connection_string}"
  version                   = "~2"

  site_config {
    always_on = true
  }

  app_settings {
    "FUNCTIONS_WORKER_RUNTIME"       = "dotnet"
    "FUNCTION_APP_EDIT_MODE"         = "readonly"
    "https_only"                     = false
    "HASH"                           = "9GXT5s57OgimBBFy7KPKzeoCHV0BYgTXZsemfKJpuR0="
    "WEBSITE_USE_ZIP"                = "https://github.com/Nepomuceno/AzureSplunkMonitor/releases/download/0.1.1/proxy.zip"
    "APPINSIGHTS_INSTRUMENTATIONKEY" = ""
    "splunkAddress"                  = ""                                                                                   // unsure if this is correct
    "splunkToken"                    = ""                                                                                   // unsure if this is correct
  }
}

/*
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
*/

