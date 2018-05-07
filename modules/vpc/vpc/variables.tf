variable "azs" {
  type = "string"
}

variable "cidr" {}
variable "depends_id" {}
variable "name" {}
variable "region" {}
variable "subnet_count" {}

variable "map_public_ip_on_launch" {
  type    = "string"
  default = "true"
}

output "depends_id" {
  value = "${null_resource.dummy_dependency.id}"
}

output "gateway_id" {
  value = "${aws_internet_gateway.main.id}"
}

output "id" {
  value = "${aws_vpc.main.id}"
}

output "route_table_id" {
  value = "${aws_route_table.private.id}"
}

# output "subnet_ids_private" {
#   value = ["${aws_subnet.private.*.id}"]
#}

# output "subnet_ids_public" {
#   value = ["${aws_subnet.public.*.id}"]
#}

output "subnet_ids_with_azs_public" {
  value = "${formatlist("%s:%s", aws_subnet.public.*.availability_zone, aws_subnet.public.*.id)}"
}

output "subnet_ids_with_azs_private" {
  value = "${formatlist("%s:%s", aws_subnet.private.*.availability_zone, aws_subnet.private.*.id)}"
}

output "subnet_ids_private" {
  value = "${join(",", aws_subnet.private.*.id)}"
}

output "subnet_ids_public" {
  value = "${join(",", aws_subnet.public.*.id)}"
}
