
resource "aws_security_group" "sgDataTier" {
	provider =  "aws.primary" 
	vpc_id = "${var.myVPCId}"

	ingress {
		from_port = 3306
		to_port = 3306
		protocol = "tcp"
		security_groups = [ "${var.mySGsAllowedIngress3306}" ]
	}
	egress {
		from_port = 0
		to_port = 0
		protocol = "-1"
		cidr_blocks = ["0.0.0.0/0"]
	}

	name = "${var.mySGName}"

}
