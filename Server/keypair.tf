#--------------------------------------------------------------
# Instances' KeyPair "${file(\"ssh_keys/sonar.pub\")}"
#--------------------------------------------------------------
resource "aws_key_pair" "SonarKey" {
	key_name   = "SonarKey"
	public_key = "${file("ssh_keys/sonar.pub")}"
}