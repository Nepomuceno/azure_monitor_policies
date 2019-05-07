variable "proxyPath" {
  description = "(optional) the proxy connection string - of the form [user:pass@]host[:port]"
  default     = ""
}

variable "prefix" {}

variable "location" {}

variable "resource_group_name" {
  default = "policy-resources"
}
