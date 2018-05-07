variable "zone_id" {
  type = "string"
}

variable "region" {
  type = "string"
}

variable "role" {
  type    = "string"
  default = "etcd"
}

variable "environment" {
  type = "string"
}

variable "dns" {
  type = "map"
}

variable "cluster_size" {
  type = "string"
}

variable "ntp_host" {
  type = "string"
}

variable "azs" {
  type = "string"
}

variable "key_name" {
  type = "string"
}

variable "launch_specification" {
  type = "map"

  default {
    ami                         = ""
    instance_type               = ""
    enable_monitoring           = ""
    associate_public_ip_address = ""
    ebs_optimized               = ""
    iam_instance_profile        = ""
    key_name                    = ""
  }
}

variable "vpc_id" {
  type = "string"
}

variable "vpc_cidr" {
  type = "string"
}

variable "ebs_volume" {
  type = "map"

  default {
    size = "100"
    type = "gp2"
  }
}

variable "subnet_ids" {
  type = "string"
}

variable "name" {
  type = "string"
}

variable "s3_bucket" {
  type = "string"
}

variable "s3_pki_bucket" {
  type = "string"
}
