# Create an AWS group
resource "spotinst_aws_group" "spotinst" {
  name        = "${var.name}"
  description = "managed by terraform"
  product     = "${var.product}"

  capacity {
    target  = "${var.capacity["target"]}"
    minimum = "${var.capacity["minimum"]}"
    maximum = "${var.capacity["maximum"]}"
  }

  strategy {
    risk = "${var.strategy_risk}"
  }

  instance_types {
    ondemand = "${var.instance_types_ondemand}"
    spot     = "${var.instance_types_spot}"
  }

  availability_zones = ["${var.subnet_ids_with_azs}"]

  launch_specification {
    monitoring           = "${var.launch_specification["monitoring"]}"
    image_id             = "${var.launch_specification["image_id"]}"
    key_pair             = "${var.launch_specification["key_pair"]}"
    security_group_ids   = ["${aws_security_group.pki.id}", "${aws_security_group.pki_alb.id}"]
    user_data            = "${element(data.template_file.cloud-init.*.rendered, count.index)}"
    iam_instance_profile = "${var.launch_specification["iam_instance_profile"]}"
  }

  load_balancer {
    name = "pki-88888"
    type = "target_group"
    arn  = "${aws_lb_target_group.pki-8888.arn}"
  }

  network_interface {
    device_index                = 0
    description                 = "default network interface"
    associate_public_ip_address = true
  }

  tags = "${var.tags}"
}
