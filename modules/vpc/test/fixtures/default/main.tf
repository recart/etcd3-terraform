# variable "length" {
#   default = "20"
#}

# resource "random_id" "name" {
#   byte_length = "${var.length * 3 / 4}"
#}

module "vpc" {
  source     = "../../../vpc/"
  depends_id = ""

  azs          = "${var.aws["azs"]}"
  subnet_count = "${var.aws["subnet_count"]}"
  cidr         = "${var.cidr["vpc"]}"
  name         = "test-vpc-main"
  region       = "${var.aws["region"]}"
}
