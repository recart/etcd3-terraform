module "s3_pki" {
  source = "./modules/s3"

  # variables
  region = "${var.aws["region"]}"
  bucket = "pki-${var.environment}-${var.aws["account_id"]}-${var.aws["region"]}"
  name   = "${var.name}"
}

resource "aws_s3_bucket_object" "ca_pem" {
  bucket = "${module.s3_pki.bucket}"
  key    = "ca.pem"
  source = "ssl/ca.pem"
  etag   = "${md5(file("ssl/ca.pem"))}"
}

resource "aws_s3_bucket_object" "ca_key_pem" {
  bucket = "${module.s3_pki.bucket}"
  key    = "ca-key.pem"
  source = "ssl/ca-key.pem"
  etag   = "${md5(file("ssl/ca-key.pem"))}"
}

resource "aws_s3_bucket_object" "ca_csr" {
  bucket = "${module.s3_pki.bucket}"
  key    = "ca.csr"
  source = "ssl/ca.csr"
  etag   = "${md5(file("ssl/ca.csr"))}"
}

resource "aws_s3_bucket_object" "ca_csr_json" {
  bucket = "${module.s3_pki.bucket}"
  key    = "ca-csr.json"
  source = "ssl/ca-csr.json"
  etag   = "${md5(file("ssl/ca-csr.json"))}"
}

resource "aws_s3_bucket_object" "ca_config_json" {
  bucket = "${module.s3_pki.bucket}"
  key    = "ca-config.json"
  source = "ssl/ca-config.json"
  etag   = "${md5(file("ssl/ca-config.json"))}"
}

resource "aws_s3_bucket_object" "service_account_key_pem" {
  bucket = "${module.s3_pki.bucket}"
  key    = "service-account-key.pem"
  source = "ssl/service-account-key.pem"
  etag   = "${md5(file("ssl/service-account-key.pem"))}"
}

module "s3_etcd" {
  source = "./modules/s3"
  region = "${var.aws["region"]}"
  bucket = "etcd-${var.environment}-${var.aws["account_id"]}-${var.aws["region"]}"
  name   = "${var.name}"
}

resource "aws_s3_bucket_object" "etcd3-bootstrap-linux-amd64" {
  bucket       = "${module.s3_etcd.bucket}"
  key          = "etcd3-bootstrap-linux-amd64"
  source       = "files/etcd3-bootstrap-linux-amd64"
  etag         = "${md5(file("files/etcd3-bootstrap-linux-amd64"))}"
  content_type = "application/octet-stream"
  acl          = "public-read"
}
