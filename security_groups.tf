#--------------------------------------------------------------
# Public SG
#--------------------------------------------------------------
resource "aws_security_group" "public" {
	name 		= "sg_public"
	description = "provides load balancer access to public and private instances"
	vpc_id 		= "${aws_vpc.ansiform.id}"

	# ssh access
	ingress {
		from_port 	= 22
		to_port   	= 22
		protocol  	= "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}

	# http access
	ingress {
		from_port   = 80
		to_port     = 80
		protocol    = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}

	egress {
		from_port   = 0
		to_port     = 0
		protocol    = "-1"
		cidr_blocks = ["0.0.0.0/0"]
	}
}

#--------------------------------------------------------------
# Private SG
#--------------------------------------------------------------
resource "aws_security_group" "private" {
	name 		= "sg_private"
	description = "used for the private instances"
	vpc_id 		= "${aws_vpc.ansiform.id}"

	# Access from other SG groups
	ingress {
		from_port 	= 0
		to_port   	= 0
		protocol  	= "-1"
		cidr_blocks = ["10.1.0.0/16"]
	}

	egress {
		from_port   = 0
		to_port     = 0
		protocol    = "-1"
		cidr_blocks = ["0.0.0.0/0"]
	}
}

#--------------------------------------------------------------
# RDS SG
#--------------------------------------------------------------
resource "aws_security_group" "rds" {
	name 		= "sg_rds"
	description = "used for the rds instances"
	vpc_id 		= "${aws_vpc.ansiform.id}"

	# Access to MYSQL Port
	ingress {
		from_port 		= 3306
		to_port   		= 3306
		protocol  		= "tcp"
		security_groups = ["${aws_security_group.public.id}", "${aws_security_group.private.id}"]
	}
}