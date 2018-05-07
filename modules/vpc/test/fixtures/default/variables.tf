variable "aws" {
  default = {
    account-id   = ""
    azs          = ""
    subnet_count = ""
    region       = ""
 }
}

variable "name" {
  default = ""
}

variable "cidr" {
  default = {
    allow-ssh = "0.0.0.0/0"
    vpc       = "10.0.0.0/16"
 }
}

provider "aws" {
  region = "${var.aws["region"]}"
}
