variable "eh_namespace" {
  description = "eventhubs namespace to be used"
}

variable "eh_name" {
  description = "name of the event hubs to be used"
}

variable "storage_name" {
  description = "name of the storage account to push the data to"
}

variable "location" {
  description = "Location where to apply the policy"
}

variable "prefix" {
  description = "Prefix to add to the resources"
}

variable "rg_name" {
  description = "name of the resource group where the logs should becreated"
}

variable "scope" {
  description = "scope where you want to apply this restrictions to"
}
