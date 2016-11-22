#--------------------------------------------------------------
# Primary Security Group
#--------------------------------------------------------------
resource "aws_security_group" "primary" {
	name        = "primary-sonar-security"
	description = "Default security group that allows inbound and outbound traffic from all instances in the VPC"
	vpc_id      = "${aws_vpc.sonar_vpc.id}"

	ingress {
		from_port = "0"
		to_port   = "0"
		protocol  = "-1"
		self      = true
	}

	egress {
		from_port   = "0"
		to_port     = "0"
		protocol    = "-1"
		self        = true
		cidr_blocks = ["0.0.0.0/0"]
	}

	tags {
		Name = "sonar-primary-vpc"
	}

	lifecycle {
		create_before_destroy = true
	}
}

#--------------------------------------------------------------
# bastion Server Security Group
#--------------------------------------------------------------
resource "aws_security_group" "bastion" {
	name        = "bastion-sonar"
	description = "Security group for bastion instances that allows SSH and VPN traffic from internet"
	vpc_id      = "${aws_vpc.sonar_vpc.id}"

	ingress {
		from_port   = 22
		to_port     = 22
		protocol    = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}

	ingress {
		from_port   = 1194
		to_port     = 1194
		protocol    = "udp"
		cidr_blocks = ["0.0.0.0/0"]
	}

	egress {
		from_port   = 80
		to_port     = 80
		protocol    = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}

    egress {
    	from_port   = 443
        to_port     = 443
    	protocol    = "tcp"
    	cidr_blocks = ["0.0.0.0/0"]
  	}

  	tags {
  		Name = "bastion-sonar"
  	}

	lifecycle {
		create_before_destroy = true
	}
}

#--------------------------------------------------------------
# Web Traffic Security Group
#--------------------------------------------------------------
resource "aws_security_group" "web" {
	name        = "web-sonar"
	description = "Security group that allows web traffic from the internet"
	vpc_id      = "${aws_vpc.sonar_vpc.id}"

	ingress {
		from_port   = 80
		to_port     = 80
		protocol    = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}

	ingress {
		from_port   = 443
		to_port     = 443
		protocol    = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}

	ingress {
		from_port   = 9000
		to_port     = 9000
		protocol    = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}

	tags {
		Name       = "web-sonar"
	}

	lifecycle {
		create_before_destroy = true
	}
}

#--------------------------------------------------------------
# Consul Security Group
#--------------------------------------------------------------
resource "aws_security_group" "consul_security_group" {
	name        = "consul"
	description = "Security group that allows web traffic from the internet"
	vpc_id      = "${aws_vpc.sonar_vpc.id}"

  // allows traffic from the SG itself for tcp
  ingress {
    from_port = 0
    to_port   = 65535
    protocol  = "tcp"
    self      = true
  }

  // allows traffic from the SG itself for udp
  ingress {
    from_port = 0
    to_port   = 65535
    protocol  = "udp"
    self      = true
  }

  // allow traffic for TCP 22 (SSH)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  // allow traffic for TCP 8300 (Server RPC)
  ingress {
    from_port   = 8300
    to_port     = 8300
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  // allow traffic for TCP 8301 (Serf LAN)
  ingress {
    from_port   = 8301
    to_port     = 8301
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  // allow traffic for UDP 8301 (Serf LAN)
  ingress {
    from_port   = 8301
    to_port     = 8301
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  // allow traffic for TCP 8400 (Consul RPC)
  ingress {
    from_port   = 8400
    to_port     = 8400
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  // allow traffic for TCP 8500 (Consul Web UI)
  ingress {
    from_port   = 8500
    to_port     = 8500
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  // allow traffic for TCP 8600 (Consul DNS Interface)
  ingress {
    from_port   = 8600
    to_port     = 8600
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  // allow traffic for UDP 8600 (Consul DNS Interface)
  ingress {
    from_port   = 8600
    to_port     = 8600
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  lifecycle {
    create_before_destroy = true
  }
}