#--------------------------------------------------------------
# VPC
#--------------------------------------------------------------
resource "aws_vpc" "ansiform" {
	cidr_block           = "${var.cidr_block}"
	enable_dns_support   = true
	enable_dns_hostnames = true

	tags{
		Name = "ansible"
	}
}

#--------------------------------------------------------------
# Internet Gateway
#--------------------------------------------------------------
resource "aws_internet_gateway" "internet_gateway" {
	vpc_id = "${aws_vpc.ansiform.id}"
}

#--------------------------------------------------------------
# Route Table - Public
#--------------------------------------------------------------
resource "aws_route_table" "public" {
	vpc_id = "${aws_vpc.ansiform.id}"

	route {
		cidr_block = "0.0.0.0/0"
		gateway_id = "${aws_internet_gateway.internet_gateway.id}"
	}

	tags {
		Name = "public"
	}
}

#--------------------------------------------------------------
# Route Table - private
#--------------------------------------------------------------
resource "aws_default_route_table" "private" {
	default_route_table_id = "${aws_vpc.ansiform.default_route_table_id}"

	tags {
		Name = "private"
	}
}

#--------------------------------------------------------------
# Subnet - Public
#--------------------------------------------------------------
