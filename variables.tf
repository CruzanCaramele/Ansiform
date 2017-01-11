#--------------------------------------------------------------
# Region and Profile to launch resources
#--------------------------------------------------------------
variable "aws_region" {
	type        = "string"
	description = "region to launch resources"
	default     = "default_value"
}

variable "aws_profile" {
	type        = "string"
	description = "profile to launch resources"
	default     = "default_value"
}