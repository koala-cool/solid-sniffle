variable "base_cidr" {
  type = string
  description = "The base cidr to allocate subnets from"
}

variable "index" {
  type = number
  description = "The name of the subnet and chunk to allocate from the base_cidr"
}

variable "public" {
  type = bool
  description = "Should subnet be accessable from the internet"
}

variable "vpc_network_id" {
  type = string
  description = "The id of the vpc network to create subnets in"
}