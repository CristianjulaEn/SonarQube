#--------------------------------------------------------------
# Load Balance
#--------------------------------------------------------------
resource "aws_elb" "balancer" {
	name            = "sonar-web-elb"
	subnets         = ["${aws_subnet.sonar_public_subnet.*.id}"]
	security_groups = ["${aws_security_group.primary.id}", "${aws_security_group.web.id}"]

	listener {
		instance_port     = 80
		instance_protocol = "http"
		lb_port           = 80
		lb_protocol       = "http"
	}

	listener {
		instance_port     = 443
		instance_protocol = "tcp"
		lb_port           = 443
		lb_protocol       = "tcp"
	}

	listener {
		instance_port     = 9000
		instance_protocol = "tcp"
		lb_port           = 9000
		lb_protocol       = "tcp"
	}

	health_check {
		healthy_threshold   = 2
		unhealthy_threshold = 2
		timeout             = 3
		target              = "HTTP:80/"
		interval            = 10
	}

	connection_draining         = true
	connection_draining_timeout = 60
	cross_zone_load_balancing   = true
	instances                   = ["${aws_instance.Sonar-Server.*.id}"]

	tags {
		monitoring = "signalfx"
	}

	lifecycle {
		create_before_destroy = true
	}
}