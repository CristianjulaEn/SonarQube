#--------------------------------------------------------------
# VPC
#--------------------------------------------------------------
resource "aws_vpc" "sonar_vpc" {
	cidr_block           = "10.139.0.0/16"
	enable_dns_support   = true
	enable_dns_hostnames = true

	tags {
		Name = "sonar_vpc"
	}

	lifecycle {
		create_before_destroy = true
	}
}

#--------------------------------------------------------------
# Internet Gateway
#--------------------------------------------------------------
resource "aws_internet_gateway" "sonar_gateway" {
	vpc_id = "${aws_vpc.sonar_vpc.id}"

	lifecycle {
		create_before_destroy = true
	}
}

#--------------------------------------------------------------
# Public Subnet
#--------------------------------------------------------------
resource "aws_subnet" "sonar_public_subnet" {
	vpc_id                 = "${aws_vpc.sonar_vpc.id}"
	cidr_block             = "${element(split(",", var.public_cidrs), count.index)}"
	availability_zone      = "${element(split(",", var.azs), count.index)}"
	count                  = "${length(split(",", var.cidrs))}"
	map_public_ip_on_lunch = true

	tags {
		Name = "sonar_public_subnet"
	}

	lifecycle {
		create_before_destroy = true
	}
}