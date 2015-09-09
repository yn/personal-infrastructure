# VPC
resource "aws_vpc" "dev" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
}

resource "aws_security_group" "allow_all_in_from_home" {
  name = "allow_all_in_from_home"
  description = "Allow all inbound traffic from home IP addresses"
  vpc_id = "${aws_vpc.dev.id}"
  
  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [
      "50.168.114.235/32" # yn's home IP
    ]
  }
}

resource "aws_internet_gateway" "dev" {
  vpc_id = "${aws_vpc.dev.id}"
}

# Public subnet

resource "aws_subnet" "dev" {
  vpc_id = "${aws_vpc.dev.id}"
  cidr_block = "10.0.0.0/24"
  map_public_ip_on_launch = true
}

resource "aws_route_table" "dev" {
  vpc_id = "${aws_vpc.dev.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.dev.id}"
  }
}

resource "aws_route_table_association" "dev" {
  subnet_id = "${aws_subnet.dev.id}"
  route_table_id = "${aws_route_table.dev.id}"
}

