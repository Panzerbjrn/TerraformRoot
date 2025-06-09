variable "region" {
  type    = string
  default = "eu"
}

variable "sp_oid" {
  type    = string
  default = null
}

variable "app_oid" {
  type    = string
  default = null
}

#Other Vars
variable "region_map" {
  type = map(string)
  default = {
    eu = "westeurope"
    us = "centralus"
    sa = "southafricanorth"
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

#From TFVARS files
# variable "RG_Map" {
#   description = "Resource Groups to create"
#   type = map(object({
#     name     = string
#     location = string
#     tags     = map(string)
#   }))
#   default = {}
# }

variable "RG_Map" {
  type = list(object({
    name        = string
    function    = string
    instance_id = string
    location    = string
    tags        = map(string)
  }))
  description = "List of Resource Groups with their properties for module usage."
  default     = []
}