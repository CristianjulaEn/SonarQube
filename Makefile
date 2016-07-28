# Makefile

terraform-dir=/d/FARAH/SonarQube/Server

build-ami:
	packer build sonar.json

plan:
	cd $(terraform-dir) && terraform plan

graph:
	cd $(terraform-dir) && terraform graph | dot -Tpng > graph.png 

build:
	cd $(terraform-dir) && terraform build

destroy:
	cd $(terraform-dir) && terraform destroy

