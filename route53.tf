resource "aws_route53_zone" "main" {
  name          = "${var.environment}.${var.dns["domain_name"]}"
  vpc_id        = "${ module.vpc.id}"
  force_destroy = true
}

# resource "aws_route53_zone_association" "secondary" {
#   zone_id = "${aws_route53_zone.example.zone_id}"
#   vpc_id  = "${aws_vpc.secondary.id}"
#}

