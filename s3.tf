#--------------------------------------------------------------
# iAM instance profile
#--------------------------------------------------------------
resource "aws_iam_instance_profile" "s3_access" {
	name = "s3_access"
    roles = ["${aws_iam_role.s3_access_role.name}"]
}

resource "aws_iam_role_policy" "s3_access_policy" {
    name = "s3_access_policy"
    role = "${aws_iam_role.s3_access_role.id}"
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "s3:*",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role" "s3_access_role" {
    name = "s3_access_role"
    path = "/"
    assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}


#--------------------------------------------------------------
# S3 Bucket
#--------------------------------------------------------------
resource "aws_s3_bucket" "s3_bucket" {
    bucket        = "${var.domain_name}_code107112"
    acl           = "private"
    force_destroy = true

    tags {
        Name = "S3 Bucket"
    }
}