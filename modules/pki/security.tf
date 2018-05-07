resource "aws_security_group" "pki" {
  description = "pki instance security group"

  egress = {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    self      = true
  }

  egress = {
    from_port   = 123
    to_port     = 123
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress = {
    from_port   = 53
    to_port     = 53
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress = {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress = {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress = {
    from_port = 8888
    to_port   = 8888
    protocol  = "tcp"

    # security_groups = ["${aws_security_group.pki_alb.id}"]
  }

  ingress = {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.vpc_cidr}", "87.229.120.179/32"]

    # security_groups = ["${var.bastion_cidr}"]
  }

  name = "pki"

  tags {
    Name      = "pki"
    builtWith = "terraform"
  }

  vpc_id = "${var.vpc_id}"
}

resource "aws_security_group" "pki_alb" {
  description = "pki application loadbalancer security group"

  egress = {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    self      = true
  }

  ingress = {
    from_port   = 8888
    to_port     = 8888
    protocol    = "tcp"
    cidr_blocks = ["${var.vpc_cidr}"]
  }

  name = "pki_alb"

  tags {
    Name      = "pki_alb"
    builtWith = "terraform"
  }

  vpc_id = "${var.vpc_id}"
}
