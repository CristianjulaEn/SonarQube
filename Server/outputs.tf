#--------------------------------------------------------------
# VPC CIDR Block
#--------------------------------------------------------------
output "vpc_cidr_block.ip" {
	value = "${aws_vpc.sonar_vpc.cidr_block}"
}

#--------------------------------------------------------------
# Subnets
#--------------------------------------------------------------
output "public_subnet_ids" {
	value = "${join(",", aws_subnet.sonar_public_subnet.*.id)}"
}

output "private_subnet_ids" {
	value = "${join(",", aws_subnet.sonar_private_subnet.*.id)}"
}

#--------------------------------------------------------------
# NAT EIPs
#--------------------------------------------------------------
output "sonar_nat_eips" {
	value = "${join(",",aws_eip.sonar_nat_eip.*.public_ip)}"
}