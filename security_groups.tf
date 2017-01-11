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
		cidr_blocks = ["${var.local_ip}"]
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