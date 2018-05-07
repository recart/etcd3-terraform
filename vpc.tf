module "vpc" {
  source       = "./modules/vpc/vpc"
  depends_id   = ""
  azs          = "${var.aws["azs"]}"
  subnet_count = "${length(formatlist("%s,%s", split(",",var.aws["azs"])))}"
  cidr         = "${var.vpc_cidr}"
  name         = "${var.environment}-${var.name}"
  region       = "${var.aws["region"]}"
}
