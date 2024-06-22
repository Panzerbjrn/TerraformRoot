#Set on command line:
variable "region" { type = string }

#Other Vars
variable "region_map" {
  type = map(string)
  default = {
    eu = "westeurope"
    us = "centralus"
    sa = "southafricanorth"
    ae = "uaenorth"
    uk = "uksouth"
  }
}

variable "env_data" {
  type    = any
  default = {}
}

variable "tags" {
  type    = any
  default = {}
}

variable "range" {
  description = "Number of resource groups to create"
  type        = number
  default     = 2
}
