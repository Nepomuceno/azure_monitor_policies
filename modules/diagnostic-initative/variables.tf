variable "generate_la_worspace" {
  description = "if should be generated a log workspace for the logs"
  default     = true
}

variable "generate_eh" {
  description = "if should be generated a eventhubs for the logs"
  default     = true
}

variable "eh_name" {
  description = "Pre geneerated event hubs name to be used"
  default     = ""
}

variable "eh_role_id" {
  description = "Pre generated event hubs role id to be used"
  default     = ""
}

variable "location" {
  description = "Location where the results should be put"
}

variable "scope" {
  description = "scope to which this rules should be applied"
}

variable "rg_name" {
  description = "name of the resource group where the logs should becreated"
}

variable "prefix" {
  description = "prefix of the resources that will be created  in this repo"
}
