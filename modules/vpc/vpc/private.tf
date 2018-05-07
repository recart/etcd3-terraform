resource "aws_eip" "nat" {
  vpc        = true
  depends_on = ["aws_internet_gateway.main"]
}

resource "aws_nat_gateway" "nat" {
  allocation_id = "${aws_eip.nat.id}"
  subnet_id     = "${aws_subnet.public.0.id}"
  depends_on    = ["aws_internet_gateway.main"]
}

# resource "aws_eip" "nat" {
#     count = "${var.subnet_count}"
#     vpc = true
#     depends_on = ["aws_internet_gateway.main"]
#}

# resource "aws_nat_gateway" "nat" {
#     count = "${var.subnet_count}"
#     allocation_id = "${element(aws_eip.nat.*.id, count.index)}"
#     subnet_id = "${element(aws_subnet.public.*.id, count.index)}"
#     depends_on = ["aws_internet_gateway.main"]
#}

resource "aws_subnet" "private" {
  count = "${length( split(",", var.azs) )}"

  availability_zone = "${element( split(",", var.azs), count.index )}"
  cidr_block        = "${cidrsubnet(var.cidr, 4, count.index + var.subnet_count)}"
  vpc_id            = "${aws_vpc.main.id}"

  tags {
    builtWith = "terraform"
    Name      = "private${count.index}"
  }
}

resource "aws_route_table" "private" {
  vpc_id = "${aws_vpc.main.id}"

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = "${element(aws_nat_gateway.nat.*.id, count.index)}"
  }

  tags {
    builtWith = "terraform"
    Name      = "private${count.index}"
  }
}

resource "aws_route_table_association" "private" {
  count = "${length(split(",", var.azs))}"

  route_table_id = "${aws_route_table.private.id}"
  subnet_id      = "${element(aws_subnet.private.*.id, count.index)}"
}
