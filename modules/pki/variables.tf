variable region {
  type = "string"
}

variable "depends_id" {}

variable capacity {
  type = "map"

  default = {
    target  = 0
    minimum = 0
    maximum = 0
  }
}

variable instance_types_ondemand {
  type = "string"
}

variable instance_types_spot {
  type = "list"
}

variable launch_specification {
  type = "map"

  default = {
    monitoring           = false
    image_id             = ""
    key_pair             = ""
    iam_instance_profile = ""
  }
}

variable launch_specification_group {
  default = {
    security_group_ids = []
  }
}

variable product {
  type    = "string"
  default = "Linux/UNIX"
}

variable subnet_ids {
  type = "string"
}

variable subnet_ids_with_azs {
  type = "list"
}

variable strategy_risk {
  type    = "string"
  default = "100"
}

variable name {
  type = "string"
}

variable tags {
  type        = "map"
  description = "A map of tags to add to all resources"
  default     = {}
}

variable "s3_bucket" {
  type = "string"
}

variable "internal_tld" {
  type = "string"
}

variable "vpc_id" {
  type = "string"
}

output "subnet_ids_with_azs" {
  value = "${var.subnet_ids_with_azs}"
}

variable "vpc_cidr" {
  type = "string"
}

variable "bastion_cidr" {
  type = "string"
}

variable "ntp_host" {
  type = "string"
}

variable "zone_id" {
  type = "string"
}

variable "dns" {
  type = "map"
}

variable "environment" {
  type = "string"
}
