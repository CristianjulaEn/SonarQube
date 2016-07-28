#--------------------------------------------------------------
# Atlas Artifact (AMI)
#--------------------------------------------------------------
resource "atlas_artifact" "SonarQube" {
	name    = "Panda/SonarQube"
	version = "latest"
	type    = "amazon.ami"
}