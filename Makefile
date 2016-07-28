# Makefile

terraform-dir=/d/FARAH/SonarQube/Server

build-ami:
	packer build sonar.json

infrastructure-plan:
	cd $(terraform-dir) && terraform plan

infrastructure-graph:
	cd $(terraform-dir) && terraform graph | dot -Tpng > graph.png 

infrastructure-build:
	cd $(terraform-dir) && terraform build

infrastructure-destroy:
	cd $(terraform-dir) && terraform destroy

