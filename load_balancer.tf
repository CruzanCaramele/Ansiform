#--------------------------------------------------------------
# Load Balancer
#--------------------------------------------------------------
resource "aws_elb" "prod" {
	name            = "${var.domain_name}-prod-elb"
	subnets         = ["${aws_subnet.private1.id}", "${aws_subnet.private2.id}"]
	security_groups = ["${aws_security_group.public.id}"]

	listener {
		lb_port           = 80
		lb_protocol       = "http"
		instance_port     = 80
		instance_protocol = "http"

	}

	health_check {
		timeout             = "${var.elb_timeout}"
		target              = "HTTP:80/"
		interval            = "${var.elb_interval}"
		healthy_threshold   = "${var.elb_healthy_threshold}"
		unhealthy_threshold = "${var.elb_unhealthy_threshold}"
	}

	idle_timeout			    = 400
	connection_draining         = true
	cross_zone_load_balancing   = true
	connection_draining_timeout = 400

	tags{
		Name = "${var.domain_name}-prod-elb"
	}
}