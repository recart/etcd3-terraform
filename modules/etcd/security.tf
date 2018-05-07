resource "aws_security_group" "etcd" {
  name        = "${var.role}.${var.region}.i.${var.environment}.${var.dns["domain_name"]}"
  description = "ASG-${var.role}"
  vpc_id      = "${var.vpc_id}"

  tags {
    Name        = "${var.role}.${var.region}.i.${var.environment}.${var.dns["domain_name"]}"
    role        = "${var.role}"
    environment = "${var.environment}"
  }

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

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    self        = true
    cidr_blocks = ["87.229.120.179/32", "80.99.74.228/32"]
  }

  # etcd peer + client traffic within the etcd nodes themselves
  ingress {
    from_port = 2379
    to_port   = 2380
    protocol  = "tcp"
    self      = true
  }

  # etcd client traffic from ELB
  egress {
    from_port = 2379
    to_port   = 2380
    protocol  = "tcp"
    self      = true
  }

  # etcd client traffic from the VPC
  ingress {
    from_port   = 2379
    to_port     = 2380
    protocol    = "tcp"
    cidr_blocks = ["${var.vpc_cidr}"]
  }

  egress {
    from_port   = 2379
    to_port     = 2380
    protocol    = "tcp"
    cidr_blocks = ["${var.vpc_cidr}"]
  }

  # pki client traffic
  egress {
    from_port   = 8888
    to_port     = 8888
    protocol    = "tcp"
    cidr_blocks = ["${var.vpc_cidr}"]
  }
}
