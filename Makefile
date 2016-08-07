# Makefile

terraform-dir=/d/FARAH/SonarQube/Server

all: plan apply

validate:
	packer validate sonar.json

infra-check:
	cd $(terraform-dir) && terraform validate

bake-ami:
	packer build sonar.json

plan:
	cd $(terraform-dir) && terraform plan

graph:
	cd $(terraform-dir) && terraform graph | dot -Tpng > graph.png 

apply:
	cd $(terraform-dir) && terraform apply

destroy:
	cd $(terraform-dir) && terraform destroy

