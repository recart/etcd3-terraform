# Create a new application load balancer
resource "aws_lb" "pki" {
  name            = "pki"
  internal        = true
  security_groups = ["${ aws_security_group.pki_alb.id}"]
  subnets         = ["${split(",", var.subnet_ids)}"]

  enable_deletion_protection = false

  tags {
    builtWith = "terraform"
    Name      = "pki"
    role      = "pki"
  }
}

resource "aws_lb_listener" "pki" {
  load_balancer_arn = "${aws_lb.pki.arn}"
  port              = "8888"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_lb_target_group.pki-8888.arn}"
    type             = "forward"
  }
}

resource "aws_lb_target_group" "pki-8888" {
  name     = "pki-8888"
  port     = 8888
  protocol = "HTTP"
  vpc_id   = "${var.vpc_id}"

  health_check {
    path = "/api/v1/cfssl/scaninfo"
  }
}
