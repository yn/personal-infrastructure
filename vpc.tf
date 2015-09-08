resource "aws_vpc" "dev" {
  cidr_block = "10.0.0.0/16"         
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
