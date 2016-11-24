# Makefile

packer-dir   =/d/FARAH/SonarQube/packer
terraform-dir=/d/FARAH/SonarQube/Server

all: plan apply

validate:
	cd $(packer-dir) && packer validate sonar.json

infra-check:
	cd $(terraform-dir) && terraform validate

bake-sonar:
	packer build sonar.json

bake-consul:
	packer build consul-servers.json

bake-bastion:
	packer build bastion.json

plan:
	cd $(terraform-dir) && terraform plan

graph:
	cd $(terraform-dir) && terraform graph | dot -Tpng > graph.png 

apply:
	cd $(terraform-dir) && terraform apply

destroy:
	cd $(terraform-dir) && terraform destroy

