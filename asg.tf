#--------------------------------------------------------------
# AMI
#--------------------------------------------------------------
resource "random_id" "ami" {
	byte_length = 8
}

resource "aws_ami_from_instance" "golden" {
	name               = "ami-${random_id.ami.b64}"
	source_instance_id = "${aws_instance.dev.id}"

	provisioner "local-exec" {
		command = "cat <<EOF > userdata\n#!/bin/bash\n/usr/bin/aws s3 sync s3://${aws_s3_bucket.s3_bucket.bucket} /var/www/html\n/bin/touch /var/spool/cron/root\nsudo /bin/echo '*/5 * * * * aws s3 sync s3://${aws_s3_bucket.s3_bucket.bucket} /var/www/html' >> /var/spool/cronEOF"
	}
}

#--------------------------------------------------------------
# Launch Configuration
#--------------------------------------------------------------
resource "aws_launch_configuration" "launch_config" {
	image_id             = "${aws_ami_from_instance.golden.id}"
	key_name             = "${aws_key_pair.auth.id}"
	user_data            = "${file("userdata")}"
	name_prefix          = "lc-"
	instance_type        = "${var.launch_config_instance_type}"
	security_groups      = ["${aws_security_group.private.id}"]
	iam_instance_profile = "${aws_iam_instance_profile.s3_access.id}"

	lifecycle {
		create_before_destroy = true
	}
}

#--------------------------------------------------------------
# AutoScaling Group
#--------------------------------------------------------------
resource "aws_autoscaling_group" "scaling_group" {
	name                	  = "asg-${aws_launch_configuration.launch_config.id}"
	availability_zones  	  = ["${var.aws_region}a","${var.aws_region}c"]
	min_size            	  = "${var.asg_min}"
	max_size	   	    	  = "${var.asg_max}"
	vpc_zone_identifier 	  = ["${aws_subnet.private1.id}", "${aws_subnet.private2.id}"]
	load_balancers      	  = ["${aws_elb.prod.id}"]
	desired_capacity          = "${var.asg_capacity}"
	health_check_type         = "${var.asg_hct}"
	health_check_grace_period = "${var.asg_grace}"
	launch_configuration      = "${aws_launch_configuration.launch_config.name}"

	tag {
		key                 = "Name"
		value               = "asg-instance"
		propagate_at_launch = true
	}

	lifecycle {
		create_before_destroy = true
	}
}