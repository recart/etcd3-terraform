resource "aws_iam_role" "iam" {
  assume_role_policy = "${var.assume_role_policy}"

  name = "${var.name}"
}

resource "aws_iam_instance_profile" "iam" {
  name = "${var.name}"
  role = "${aws_iam_role.iam.name}"
}

resource "aws_iam_role_policy" "iam" {
  name   = "${var.name}"
  role   = "${aws_iam_role.iam.id}"
  policy = "${var.iam_role_policy}"
}

# resource "null_resource" "dummy_dependency" {
#   depends_on = [
#     "aws_iam_role.iam",
#     "aws_iam_role_policy.iam",
#     "aws_iam_instance_profile.iam",
#   ]
#}

