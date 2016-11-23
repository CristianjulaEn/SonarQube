#--------------------------------------------------------------
# Atlas Artifacts (AMIs) 
#--------------------------------------------------------------
data "atlas_artifact" "SonarQube" {
	name    = "Panda/SonarQube"
	version = "latest"
	type    = "amazon.image"
}

data "atlas_artifact" "ConsulServer" {
	name    = "Panda/ConsulServer"
	version = "latest"
	type    = "amazon.image"
}

#--------------------------------------------------------------
# Instance(s) Sonar
#--------------------------------------------------------------
resource "aws_instance" "Sonar-Server" {
	ami             = "${data.atlas_artifact.SonarQube.metadata_full.region-us-east-1}"
	instance_type   = "c3.large"
	subnet_id       = "${element(aws_subnet.sonar_private_subnet.*.id, count.index)}"
	depends_on      = ["aws_instance.BastionInstance"]
	security_groups = ["${aws_security_group.primary.id}","${aws_security_group.consul_security_group.id}"]
	key_name        = "${aws_key_pair.SonarKey.key_name}"
	monitoring      = true
	count           = 2

	tags {
		Name       = "Sonar-Server"
		role       = "app-server"
		monitoring = "consul"
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

#--------------------------------------------------------------
# Instance(s) Consul
#--------------------------------------------------------------
resource "aws_instance" "Consul-Server" {
	ami             = "${data.atlas_artifact.ConsulServer.metadata_full.region-us-east-1}"
	instance_type   = "c3.large"
	subnet_id       = "${element(aws_subnet.sonar_private_subnet.*.id, count.index)}"
	security_groups = ["${aws_security_group.primary.id}", "${aws_security_group.consul_security_group.id}"]
	key_name        = "${aws_key_pair.SonarKey.key_name}"
	monitoring      = true
	count           = 3

	tags {
		Name       = "Consul-Server"
		role       = "consul-server"
		monitoring = "consul"
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

