variable "subnet" {
  type = string
  description = "Subnet to assign instance to"
}

variable "zone" {
  type = string
  description = "Zone to assign instance and disk to"
}

variable "name" {
  type = string
  description = "Name to prepend to the instance and disk"
}

variable "script" {
  default = ""
  type = string
  description = "Script to run on startup on created instance"
}