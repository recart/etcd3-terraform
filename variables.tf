provider "aws" {
  region  = "us-east-1"
  profile = "dev"
}

provider "spotinst" {
  token   = "a8e6b4d417a4d345718d1da28b973eaea97651edcac2d3034544ee10512c80b7"
  account = "act-beb541df"
}

variable "aws" {
  type = "map"

  default {
    region     = "us-east-1"
    account_id = "010041307211"
    azs        = "us-east-1a,us-east-1b,us-east-1c,us-east-1d,us-east-1e,us-east-1f"
  }
}

variable "instance_type" {
  default = "t2.medium"
}

variable "environment" {
  default = "staging"
}

variable "role" {
  default = "etcd3-test"
}

variable "ami" {
  default = "ami-9e2685e3"
}

variable "vpc_cidr" {
  default = "10.200.0.0/16"
}

variable "dns" {
  type = "map"

  default = {
    domain_name = "infrastracture.local"
  }
}

variable "ssl_upload" {
  default = false
}

variable "key_name" {
  default = "david-key"
}

variable "cluster_size" {
  default = 3
}

variable "ntp_host" {
  default = "0.europe.pool.ntp.org"
}

variable "name" {
  default = "etcd"
}

variable "bastion_cidr" {
  default = "0.0.0.0/0"
}

variable "src_version" {
  default = "0.1"
}
