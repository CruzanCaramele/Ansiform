#--------------------------------------------------------------
# DB Instance
#--------------------------------------------------------------
resource "aws_db_instance" "db" {
	allocated_storage      = 10
  	engine                 = "mysql"
  	engine_version         = "5.6.27"
  	instance_class         = "${var.db_instance_class}"
  	name                   = "${var.dbname}"
  	username               = "${var.dbuser}"
  	password               = "${var.dbpassword}"
  	db_subnet_group_name   = "${aws_db_subnet_group.rds_subnet.name}"
  	vpc_security_group_ids = ["${aws_security_group.rds.id}"]
}

#--------------------------------------------------------------
# Dev Instance
#--------------------------------------------------------------
resource "aws_instance" "dev" {
	instance_type = "${var.dev_instance_type}"
	ami           = "${var.dev_ami}"

	tags {
		Name = "dev"
	}

	key_name               = "${aws_key_pair.auth.key_name}"
	vpc_security_group_ids = ["${aws_security_group.public.id}"]
	iam_instance_profile   = "${aws_iam_instance_profile.s3_access.id}"
	subnet_id              = "${aws_subnet.public.id}"

	provisioner "local-exec" {
		command = "cat <<EOF > aws_hosts\n[dev]\n${aws_instance.dev.public_ip}\n[dev:vars]\ns3code=${aws_s3_bucket.s3_bucket.bucket}\nEOF"
	}

	provisioner "local-exec" {
		command = "cat <<EOF > aws\n[dev]\ndevian=${aws_instance.dev.public_ip}\nEOF"
	}

	provisioner "local-exec" {
		command = "sleep 6m && ansible-playbook -i aws_hosts wordpress.yml"
	}
}