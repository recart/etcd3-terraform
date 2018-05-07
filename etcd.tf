module "etcd" {
  source        = "./modules/etcd"
  zone_id       = "${aws_route53_zone.main.zone_id}"
  name          = "${var.name}"
  dns           = "${var.dns}"
  key_name      = "${var.key_name}"
  azs           = "${var.aws["azs"]}"
  region        = "${var.aws["region"]}"
  environment   = "${var.environment}"
  cluster_size  = "${var.cluster_size}"
  ntp_host      = "${var.ntp_host}"
  vpc_id        = "${module.vpc.id}"
  vpc_cidr      = "${var.vpc_cidr}"
  subnet_ids    = "${module.vpc.subnet_ids_public}"
  s3_bucket     = "${module.s3_etcd.bucket}"
  s3_pki_bucket = "${module.s3_pki.bucket}"

  launch_specification = {
    enable_monitoring           = false
    ami                         = "${var.ami}"
    key_name                    = "${var.key_name}"
    iam_instance_profile        = "${module.iam_etcd.instance_profile_name}"
    instance_type               = "${var.instance_type}"
    ebs_optimized               = false
    associate_public_ip_address = true
  }
}
