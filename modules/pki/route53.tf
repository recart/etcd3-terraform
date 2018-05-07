resource "aws_route53_record" "A-pki" {
  zone_id = "${var.zone_id}"
  name    = "pki.${var.region}.i.${var.environment}.${var.dns["domain_name"]}"
  type    = "A"

  alias {
    name                   = "${aws_lb.pki.dns_name}"
    zone_id                = "${aws_lb.pki.zone_id}"
    evaluate_target_health = false
  }
}
