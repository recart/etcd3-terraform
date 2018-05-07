module "lambda" {
  source      = "./modules/lambda"
  zone_id     = "${aws_route53_zone.main.zone_id}"
  name        = "${var.name}"
  dns         = "${var.dns}"
  region      = "${var.aws["region"]}"
  environment = "${var.environment}"
  src_version = "${var.src_version}"
  role        = "etcd"
}
