#--------------------------------------------------------------
# Atlas Artifact (AMI)
#--------------------------------------------------------------
data "atlas_artifact" "SonarQube" {
	name    = "Panda/SonarQube"
	version = "latest"
	type    = "amazon.image"
}	

#--------------------------------------------------------------
# Instance(s)
#--------------------------------------------------------------
resource "aws_instance" "Sonar-Server" {
	ami             = "${data.atlas_artifact.SonarQube.metadata_full.region-us-east-1}"
	instance_type   = "c3.large"
	subnet_id       = "${element(aws_subnet.sonar_private_subnet.*.id, count.index)}"
	security_groups = ["${aws_security_group.primary.id}"]
	depends_on      = ["aws_internet_gateway.sonar_gateway"]
	key_name        = "${aws_key_pair.SonarKey.key_name}"
	monitoring      = true
	count           = 3

	tags {
		Name       = "Sonar-Server"
		role       = "app-server"
		monitoring = ""
	}

	connection {
		user         = "ubuntu"
		key_file     = "${var.key_file}"
		bastion_host = "${aws_eip.BastionEip.public_ip}"
		agent        = false
	}
	
	lifecycle {
		create_before_destroy = true
	}
}

