variable "proxyPath" {
  description = "(optional) the proxy connection string - of the form [user:pass@]host[:port]"
  default     = ""
}

variable "storage_name" {}

variable "storage_sas_key" {}

variable "eh_sas_url" {}

variable "prefix" {}

variable "location" {}

variable "resource_group_name" {
  default = "policy-resources"
}
