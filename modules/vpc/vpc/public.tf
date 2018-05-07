resource "aws_internet_gateway" "main" {
  vpc_id = "${aws_vpc.main.id}"

  tags {
    builtWith = "terraform"
    Name      = "${var.name}"
  }
}

resource "aws_subnet" "public" {
  count = "${length( split(",", var.azs) )}"

  availability_zone       = "${element( split(",", var.azs), count.index )}"
  cidr_block              = "${cidrsubnet(var.cidr, 8, count.index)}"
  vpc_id                  = "${aws_vpc.main.id}"
  map_public_ip_on_launch = "${var.map_public_ip_on_launch}"

  tags {
    builtWith = "terraform"
    Name      = "public${count.index}"
  }
}

resource "aws_route" "public" {
  route_table_id         = "${aws_route_table.public.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.main.id}"
}

resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.main.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.main.id}"
  }

  tags {
    builtWith = "terraform"
    Name      = "public${count.index}"
  }
}

resource "aws_main_route_table_association" "a" {
  vpc_id         = "${aws_vpc.main.id}"
  route_table_id = "${aws_route_table.public.id}"
}

resource "aws_route_table_association" "public" {
  count = "${length(split(",", var.azs))}"

  route_table_id = "${aws_route_table.public.id}"
  subnet_id      = "${element(aws_subnet.public.*.id, count.index)}"
}
