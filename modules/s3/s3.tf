resource "aws_s3_bucket" "main" {
  acl           = "${var.acl}"
  bucket        = "${var.bucket}"
  force_destroy = true

  region = "${var.region}"

  tags {
    builtWith = "terraform"
    Name      = "${var.name}"
 }
}
