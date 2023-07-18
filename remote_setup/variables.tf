#############################################################################
# VARIABLES
#############################################################################

variable "location" {
  type    = string
  default = "eastus"
}

variable "naming_prefix" {
  type    = string
  default = "transit-api"
}

variable "github_repository" {
  type    = string
  default = "transit-infra"
}

variable "token" {
  type    = string
  default = "pat_goes_here"
}