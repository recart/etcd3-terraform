# variable "depends_id" {}
variable "name" {}

variable "assume_role_policy" {}
variable "iam_role_policy" {}

# output "depends_id" { value = "${null_resource.dummy_dependency.id}"}
output "instance_profile_name" {
  value = "${aws_iam_instance_profile.iam.name}"
}
