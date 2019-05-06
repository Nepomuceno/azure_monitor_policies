variable "proxyPath" {
  description = "(optional) the proxy connection string - of the form [user:pass@]host[:port]"
  default     = ""
}

variable "vmResourceId" {
  description = "the resource id of the vm where you want to add the extension"
  default     = ""
}

variable "workspaceKey" {
  description = "the key of the workspace you want to use"
}

variable "workspaceId" {
  description = "the GUID id of the worspace to push the telemetry to"
}

variable "prefix" {}

variable "location" {}

variable "resource_group_name" {
  default = "policy-resources"
}
