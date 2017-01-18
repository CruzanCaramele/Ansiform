#--------------------------------------------------------------
# Region and Profile to launch resources
#--------------------------------------------------------------
variable "aws_region" {
	type        = "string"
	description = "region to launch resources"
}

variable "aws_profile" {
	type        = "string"
	description = "profile to launch resources"
}

variable "aws_access_key" {
	type        = "string"
	description = "profile to launch resources"
}
variable "aws_secret_key" {
	type        = "string"
	description = "profile to launch resources"
}


#--------------------------------------------------------------
#CIDR BLOCKS
#--------------------------------------------------------------
variable "cidr_block" {
	type         = "string"
	description  = "VPC CIDR Block Range"
	default      = "10.1.0.0/16"
}

variable "public_cidr" {
	type        = "string"
	description = "describe your variable"
	default     = "10.1.1.0/24"
}

variable "private1_cidr" {
	type        = "string"
	description = "describe your variable"
	default     = "10.1.2.0/24"
}

variable "private2_cidr" {
	type        = "string"
	description = "describe your variable"
	default     = "10.1.3.0/24"
}

variable "rds1_cidr" {
	type        = "string"
	description = "describe your variable"
	default     = "10.1.4.0/24"
}

variable "rds2_cidr" {
	type        = "string"
	description = "describe your variable"
	default     = "10.1.5.0/24"
}

variable "rds3_cidr" {
	type        = "string"
	description = "describe your variable"
	default     = "10.1.6.0/24"
}

#--------------------------------------------------------------
# SSH local IP Variable
#--------------------------------------------------------------
# variable "local_ip" {
# 	type 		= "string"
# 	description = "describe your variable"
# }

#--------------------------------------------------------------
# DB Instance Variables
#--------------------------------------------------------------
variable "db_instance_class" {
	type        = "string"
	description = "db instance type"
}

variable "dbname" {
	type        = "string"
	description = "database name"
}

variable "dbuser" {
	type        = "string"
	description = "db admin user"
}
variable "dbpassword" {
	type        = "string"
	description = "db admin password"
}

#--------------------------------------------------------------
# SSH Keypair Variables
#--------------------------------------------------------------
variable "key_name" {
	type        = "string"
	description = "ssh key name" 
}

variable "public_key_path" {
	type        = "string"
	description = "path to file for public key " 
}

#--------------------------------------------------------------
# Domain Name & instance type
#--------------------------------------------------------------
variable "domain_name" {
	type        = "string"
	description = "domain name" 
}

variable "dev_instance_type" {
	type        = "string"
	description = "instance type" 
}

variable "dev_ami" {
	type        = "string"
	description = "AMI to be used on instances" 
}

#--------------------------------------------------------------
# ELB Variables
#--------------------------------------------------------------
variable "elb_timeout" {
	type        = "string"
	description = "time out" 
}

variable "elb_interval" {
	type        = "string"
	description = "interval time" 
}

variable "elb_healthy_threshold" {
	type        = "string"
	description = "helth check" 
}

variable "elb_unhealthy_threshold" {
	type        = "string"
	description = "unhealthy check" 
}


#--------------------------------------------------------------
# Auto-Scaling Variables
#--------------------------------------------------------------
variable "asg_min" {
	type        = "string"
	description = "min instances" 
}

variable "asg_max" {
	type        = "string"
	description = "max instances" 
}

variable "asg_hct" {
	type        = "string"
	description = "scaling group health check type" 
}

variable "asg_grace" {
	type        = "string"
	description = "scaling group grace period" 
}

variable "asg_capacity" {
	type        = "string"
	description = "scaling group capacity" 
}

variable "launch_config_instance_type" {
	type 		= "string"
	description = "instance type to launch"
}

#--------------------------------------------------------------
# Route53 variables
#--------------------------------------------------------------
variable "delegation_set" {
	type        = "string"
	description = "delegation_set" 
}