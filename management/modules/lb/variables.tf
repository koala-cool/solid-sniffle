variable "instances" {
  type = list
  description = "Instances to put into instance group"
}

variable "zone" {
  type = string
  description = "Zone to assign instance and disk to"
}

variable "name" {
  type = string
  description = "Name to prepend to the healthcheck, group, and backend service"
}