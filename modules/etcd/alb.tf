# Create a new application load balancer
resource "aws_lb" "etcd" {
  name     = "etcd"
  internal = true

  #   security_groups    = ["${ aws_security_group.default.id}"]
  subnets            = ["${split(",", var.subnet_ids)}"]
  load_balancer_type = "network"

  enable_deletion_protection = false

  tags {
    builtWith   = "terraform"
    Name        = "${var.role}.${var.region}.i.${var.environment}.${var.dns["domain_name"]}"
    environment = "${var.environment}"
    role        = "${var.role}"
 }
}

resource "aws_lb_listener" "etcd" {
  load_balancer_arn = "${aws_lb.etcd.arn}"
  port              = "2379"
  protocol          = "TCP"

  default_action {
    target_group_arn = "${aws_lb_target_group.etcd-2379.arn}"
    type             = "forward"
 }
}

resource "aws_lb_target_group" "etcd-2379" {
  name     = "etcd-2379"
  port     = 2379
  protocol = "TCP"
  vpc_id   = "${var.vpc_id}"
}
