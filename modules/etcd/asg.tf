resource "aws_launch_configuration" "etcd" {
  count                       = "${var.cluster_size}"
  name_prefix                 = "peer-${count.index}.${var.role}.${var.region}.i.${var.environment}.${var.dns["domain_name"]}"
  image_id                    = "${var.launch_specification["ami"]}"
  instance_type               = "${var.launch_specification["instance_type"]}"
  ebs_optimized               = "${var.launch_specification["ebs_optimized"]}"
  iam_instance_profile        = "${var.launch_specification["iam_instance_profile"]}"
  key_name                    = "${var.launch_specification["key_name"]}"
  enable_monitoring           = "${var.launch_specification["enable_monitoring"]}"
  associate_public_ip_address = "${var.launch_specification["associate_public_ip_address"]}"
  user_data                   = "${element(data.template_file.cloud-init.*.rendered, count.index)}"
  security_groups             = ["${aws_security_group.etcd.id}"]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "etcd" {
  count                     = "${var.cluster_size}"
  availability_zones        = ["${element(split(",",var.azs), count.index)}"]
  name                      = "peer-${count.index}.${var.role}.${var.region}.i.${var.environment}.${var.dns["domain_name"]}"
  max_size                  = 1
  min_size                  = 1
  desired_capacity          = 1
  health_check_grace_period = 30
  health_check_type         = "EC2"
  force_delete              = true
  launch_configuration      = "${element(aws_launch_configuration.etcd.*.name, count.index)}"
  vpc_zone_identifier       = ["${element(split(",", var.subnet_ids), count.index)}"]
  target_group_arns         = ["${aws_lb_target_group.etcd-2379.arn}"]
  wait_for_capacity_timeout = "0"

  tag {
    key                 = "Name"
    value               = "peer-${count.index}.${var.role}.${var.region}.i.${var.environment}.${var.dns["domain_name"]}"
    propagate_at_launch = true
  }

  tag {
    key                 = "environment"
    value               = "${var.environment}"
    propagate_at_launch = true
  }

  tag {
    key                 = "role"
    value               = "peer-${count.index}.${var.role}"
    propagate_at_launch = true
  }

  tag {
    key                 = "r53-domain-name"
    value               = "${var.environment}.${var.dns["domain_name"]}"
    propagate_at_launch = false
  }

  tag {
    key                 = "r53-zone-id"
    value               = "${var.zone_id}"
    propagate_at_launch = false
  }
}

resource "aws_ebs_volume" "ssd" {
  count             = "${var.cluster_size}"
  type              = "${var.ebs_volume["type"]}"
  availability_zone = "${element(split(",",var.azs), count.index)}"
  size              = "${var.ebs_volume["size"]}"

  tags {
    "Name"        = "peer-${count.index}-ssd.${var.role}.${var.region}.i.${var.environment}.${var.dns["domain_name"]}"
    "environment" = "${var.environment}"
    "role"        = "peer-${count.index}-ssd.${var.role}"
  }
}
