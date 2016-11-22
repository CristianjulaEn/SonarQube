#--------------------------------------------------------------
# Database Instance
#--------------------------------------------------------------
resource "aws_db_instance" "SonarDatabase" {
	name 		           = "SonarDatabase"
	port                   = 5432
	engine                 = "postgres"
	multi_az               = false
	username               = "sonar"
	password               = "supersecretpassword"
	identifier             = "sonar-database"
	engine_version         = "9.4.7"
	instance_class         = "db.t1.micro"
	allocated_storage      = 5
	db_subnet_group_name   = "${aws_db_subnet_group.databse_subnet.name}"
	vpc_security_group_ids = ["${aws_security_group.primary.id}"]

	tags {
		Name = "SonarDatabase"
		monitoring = "consul"
	}

	lifecycle {
		create_before_destroy = true
	}
}

#--------------------------------------------------------------
# Database Subnet
#--------------------------------------------------------------
resource "aws_db_subnet_group" "databse_subnet" {
	name       = "databse_subnet"
	subnet_ids = ["${aws_subnet.sonar_private_subnet.*.id}"]

	lifecycle {
		create_before_destroy = true
	}
}