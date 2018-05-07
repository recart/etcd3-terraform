resource "aws_route53_record" "ssl" {
  zone_id = "${var.zone_id}"
  name    = "_etcd-server-ssl._tcp.${var.role}.${var.region}.i.${var.environment}.${var.dns["domain_name"]}"
  type    = "SRV"
  ttl     = "1"
  records = ["${formatlist("0 0 2380 %s", aws_route53_record.peers.*.name)}"]
}

resource "aws_route53_record" "ssl_client" {
  zone_id = "${var.zone_id}"
  name    = "_etcd-client-ssl._tcp.${var.role}.${var.region}.i.${var.environment}.${var.dns["domain_name"]}"
  type    = "SRV"
  ttl     = "1"
  records = ["${formatlist("0 0 2380 %s", aws_route53_record.peers.*.name)}"]
}

# resource "aws_route53_record" "non_ssl" {
#   zone_id = "${var.zone_id}"
#   name    = "_etcd-server._tcp.${var.role}.${var.region}.i.${var.environment}.${var.dns["domain_name"]}"
#   type    = "SRV"
#   ttl     = "1"
#   records = ["${formatlist("0 0 2380 %s", aws_route53_record.peers.*.name)}"]
# }

resource "aws_route53_record" "peers" {
  count   = "${var.cluster_size}"
  zone_id = "${var.zone_id}"
  name    = "peer-${count.index}.${var.role}.${var.region}.i.${var.environment}.${var.dns["domain_name"]}"
  type    = "A"
  ttl     = "1"
  records = ["198.51.100.${count.index}"]

  lifecycle {
    ignore_changes = ["records"]
  }
}

resource "aws_route53_record" "etcd_lb" {
  zone_id = "${var.zone_id}"
  name    = "${var.role}.${var.region}.i.${var.environment}.${var.dns["domain_name"]}"
  type    = "A"

  alias {
    name                   = "${aws_lb.etcd.dns_name}"
    zone_id                = "${aws_lb.etcd.zone_id}"
    evaluate_target_health = false
  }
}
