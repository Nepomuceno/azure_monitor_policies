variable "storage_name" {
  description = "Name of the storage account that you need the logs to be stored at."
}

variable "storage_sas_key" {
  description = "SAS key of the storage account that you will be storing the metrics at"
}

variable "eh_sas_url" {
  description = "Eh SAS url in the format https://${ehNamespace}.servicebus.windows.net/${ehName}?sr=${ehNamespace}.servicebus.windows.net%2f${ehName}&sig=${ehKey}&skn=${ehKeyName}"
}

variable "prefix" {}

variable "location" {}

variable "resource_group_name" {
  default = "policy-resources"
}
