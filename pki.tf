module "pki" {
  source                  = "./modules/pki"
  depends_id              = "${module.vpc.depends_id}"
  region                  = "${var.aws["region"]}"
  name                    = "${var.environment}-pki"
  dns                     = "${var.dns}"
  environment             = "${var.environment}"
  subnet_ids_with_azs     = "${module.vpc.subnet_ids_with_azs_public}"
  subnet_ids              = "${module.vpc.subnet_ids_public}"
  vpc_id                  = "${module.vpc.id}"
  vpc_cidr                = "${var.vpc_cidr}"
  bastion_cidr            = "${var.bastion_cidr}"
  ntp_host                = "${var.ntp_host}"
  zone_id                 = "${aws_route53_zone.main.zone_id}"
  instance_types_ondemand = "t2.medium"
  instance_types_spot     = ["t2.medium", "t2.large"]

  launch_specification = {
    monitoring           = false
    image_id             = "${var.ami}"
    key_pair             = "${var.key_name}"
    iam_instance_profile = "${module.iam_pki.instance_profile_name}"
  }

  capacity = {
    target  = 2
    minimum = 2
    maximum = 2
  }

  tags = {
    builtWith = "terraform"
    Name      = "pki"
    role      = "pki"
  }

  # variables
  internal_tld = "${var.dns["domain_name"]}"
  s3_bucket    = "${module.s3_pki.bucket}"
}
