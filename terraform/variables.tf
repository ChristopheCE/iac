variable "location" {
  type        = string
  default     = "westeurope"
  description = "Location of the resources"
}

variable "tags" {
  type        = map(string)
}

variable "environment_code" {
  type        = string
  description = "Abbreviated environment name"
}