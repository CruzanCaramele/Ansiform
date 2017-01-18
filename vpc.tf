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
resource "aws_subnet" "public" {
	vpc_id     				= "${aws_vpc.ansiform.id}"
	cidr_block 				= "${var.public_cidr}"
	availability_zone 		= "us-east-1d"
	map_public_ip_on_launch = true 

	tags{
		Name = "public"
	}
}

#--------------------------------------------------------------
# Subnets - Private
#--------------------------------------------------------------
resource "aws_subnet" "private1" {
	vpc_id     				= "${aws_vpc.ansiform.id}"
	cidr_block 				= "${var.private1_cidr}"
	availability_zone 		= "us-east-1e"
	map_public_ip_on_launch = false 

	tags{
		Name = "private1"
	}
}

resource "aws_subnet" "private2" {
	vpc_id     				= "${aws_vpc.ansiform.id}"
	cidr_block 				= "${var.private2_cidr}"
	availability_zone 		= "us-east-1c"
	map_public_ip_on_launch = false 

	tags{
		Name = "private2"
	}
}

resource "aws_subnet" "rds1" {
	vpc_id     				= "${aws_vpc.ansiform.id}"
	cidr_block 				= "${var.rds1_cidr}"
	availability_zone 		= "us-east-1e"
	map_public_ip_on_launch = false 

	tags{
		Name = "rds1"
	}
}

resource "aws_subnet" "rds2" {
	vpc_id     				= "${aws_vpc.ansiform.id}"
	cidr_block 				= "${var.rds2_cidr}"
	availability_zone 		= "us-east-1c"
	map_public_ip_on_launch = false 

	tags{
		Name = "rds2"
	}
}

resource "aws_subnet" "rds3" {
	vpc_id     				= "${aws_vpc.ansiform.id}"
	cidr_block 				= "${var.rds3_cidr}"
	availability_zone 		= "us-east-1d"
	map_public_ip_on_launch = false 

	tags{
		Name = "rds3"
	}
}

#--------------------------------------------------------------
# Route Table Associations
#--------------------------------------------------------------
resource "aws_route_table_association" "public_association" {
	subnet_id      = "${aws_subnet.public.id}"
	route_table_id = "${aws_route_table.public.id}" 
}

resource "aws_route_table_association" "priavte1_association" {
	subnet_id      = "${aws_subnet.private1.id}"
	route_table_id = "${aws_route_table.public.id}" 
}

resource "aws_route_table_association" "priavte2_association" {
	subnet_id      = "${aws_subnet.private2.id}"
	route_table_id = "${aws_route_table.public.id}" 
}

#--------------------------------------------------------------
# RDS Subnet Group
#--------------------------------------------------------------
resource "aws_db_subnet_group" "rds_subnet" {
	name 	   = "rds_subnet"
	subnet_ids = ["${aws_subnet.rds1.id}", "${aws_subnet.rds2.id}", "${aws_subnet.rds3.id}"]

	tags {
		Name = "rds_subnets"
	}
}

#--------------------------------------------------------------
# S3 VPC Endpoint
#--------------------------------------------------------------
resource "aws_vpc_endpoint" "private-s3" {
    vpc_id          = "${aws_vpc.ansiform.id}"
    service_name    = "com.amazonaws.${var.aws_region}.s3"
    route_table_ids = ["${aws_vpc.ansiform.main_route_table_id}", "${aws_route_table.public.id}"]
    policy          = <<POLICY
{
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "*",
      "Resource": "*",
      "Principal": "*"
    }
  ]
}
POLICY
}