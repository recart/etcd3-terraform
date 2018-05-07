variable "region" {}

variable "acl" {
  default = "private"
}

variable "bucket" {}
variable "name" {}

output "bucket" {
  value = "${var.bucket}"
}

output "bucket_arn" {
  value = "${aws_s3_bucket.main.arn}"
}

output "bucket_domain_name" {
  value = "${aws_s3_bucket.main.bucket_domain_name}"
}
