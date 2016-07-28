#--------------------------------------------------------------
# Atlas Artifact (AMI)
#--------------------------------------------------------------
resource "atlas_artifact" "SonarQube" {
	name    = "Panda/SonarQube"
	version = "latest"
	type    = "amazon.ami"
}

#--------------------------------------------------------------
# Instance(s)
#--------------------------------------------------------------
resource "aws_instance" "Sonar-Server" {
	ami             = "${atlas_artifact.SonarQube.metadata_full.ami_id}"
	instance_type   = "c3.large"
	subnet_id       = "${element(aws_subnet.sonar_private_subnet.*.id, count.index)}"
	security_groups = ["${aws_security_group.primary.id}"]
	depends_on      = ["aws_internet_gateway.sonar_gateway"]
	count           = 3

	lifecycle {
		create_before_destroy = true
	}
}

