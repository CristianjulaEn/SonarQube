#--------------------------------------------------------------
# VPC
#--------------------------------------------------------------
resource "aws_vpc" "sonar_vpc" {
	cidr_block           = "172.31.0.0/16"
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
	count                  = "${length(split(",", var.azs))}"
	map_public_ip_on_launch = true

	tags {
		Name = "sonar_public_subnet"
	}

	lifecycle {
		create_before_destroy = true
	}
}

resource "aws_route_table" "public_route_table" {
	vpc_id = "${aws_vpc.sonar_vpc.id}"

	route {
		cidr_block = "0.0.0.0/0"
		gateway_id = "${aws_internet_gateway.sonar_gateway.id}"
	}

	lifecycle {
		create_before_destroy = true
	}

	tags {
		Name = "main"
	}
}

resource "aws_main_route_table_association" "public" {
    vpc_id         = "${aws_vpc.sonar_vpc.id}"
    route_table_id = "${aws_route_table.public_route_table.id}"

    lifecycle {
    	create_before_destroy = true
    }
}

resource "aws_route_table_association" "public_route_association" {
	subnet_id      = "${element(aws_subnet.sonar_public_subnet.*.id, count.index)}"
	route_table_id = "${aws_route_table.public_route_table.id}"

	lifecycle {
		create_before_destroy = true
	}
}

#--------------------------------------------------------------
# Private Subnet
#--------------------------------------------------------------
resource "aws_subnet" "sonar_private_subnet" {
	vpc_id                  = "${aws_vpc.sonar_vpc.id}"
	cidr_block              = "${element(split(",", var.private_cidrs), count.index)}"
	availability_zone       = "${element(split(",", var.azs), count.index)}"
	count                   = "${length(split(",", var.azs))}"
	map_public_ip_on_launch = false

	tags {
		Name = "private_subnet"
	}

	lifecycle {
		create_before_destroy = true
	}
}

resource "aws_route_table" "private_route_table" {
	vpc_id = "${aws_vpc.sonar_vpc.id}"
	count  = "${length(split(",", var.azs))}"

	route {
		cidr_block     = "0.0.0.0/0"
		nat_gateway_id = "${element(aws_nat_gateway.sonar_nat.*.id, count.index)}"
	}

	tags {
		Name = "private_route_table"
	}

	lifecycle {
		create_before_destroy = true
	}
}

resource "aws_route_table_association" "private_route_table_association" {
	subnet_id      = "${element(aws_subnet.sonar_private_subnet.*.id, count.index)}"
	route_table_id = "${element(aws_route_table.private_route_table.*.id, count.index)}"
	count          = "${length(split(",", var.azs))}"

	lifecycle {
		create_before_destroy = true
	} 
}

#--------------------------------------------------------------
# NAT Eip
#--------------------------------------------------------------
resource "aws_eip" "sonar_nat_eip" {
	vpc   = true
	count = "${length(split(",", var.azs))}"

	lifecycle {
		create_before_destroy = true
	}
}

#--------------------------------------------------------------
# NAT Gateway
#--------------------------------------------------------------
resource "aws_nat_gateway" "sonar_nat" {
	count         = "${length(split(",", var.azs))}"
	allocation_id = "${element(aws_eip.sonar_nat_eip.*.id, count.index)}"
	subnet_id     = "${element(aws_subnet.sonar_public_subnet.*.id, count.index)}"

	lifecycle {
		create_before_destroy = true
	}
}
