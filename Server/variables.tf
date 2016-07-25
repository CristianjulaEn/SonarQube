#--------------------------------------------------------------
# Access and Secret Keys
#--------------------------------------------------------------
variable "aws_access_key" {
	type        = "string"
	description = "Access Key Account"
	default     = "{{env `AWS_ACCESS_KEY_ID`}}"
}

variable "aws_secret_key" {
	type        = "string"
	description = "Secret Key Account"
	default     = "{{env `AWS_SECRET_ACCESS_KEY`}}"
}

#--------------------------------------------------------------
# Availability Zones
#--------------------------------------------------------------
variable "azs" {
	type = "string"
	description = "Availability Zones"
	default = "us-east-1a,us-east-1c,us-east-1e"
}

#--------------------------------------------------------------
# Public & Private CIDRs
#--------------------------------------------------------------
variable "public_cidrs" {
	type = "string"
	description = "public network blocks"
	default = "172.31.0.0/20,172.31.16.0/20,172.31.32.0/20"
}

variable "private_cidrs" {
	type = "string"
	description = "private network blocks"
	default = "172.31.48.0/20,172.31.64.0/20,172.31.80.0/20"
}

