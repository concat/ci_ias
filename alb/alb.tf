resource "aws_alb" "myALB" {
	provider =  "aws.primary"
	name = "${var.myALBProperties["albname"]}"
	subnets = [ "${var.mySubnetIds}" ]
	security_groups = [ "${var.mySGIds}" ]

	internal = "${var.myALBProperties["internalLB"]}"
}

resource "aws_alb_target_group" "thisTG" {
	provider =  "aws.primary"	
	name = "${var.myALBProperties["targetgroupname"]}"
	port = "${var.myALBProperties["targetgroupport"]}"
	protocol = "${var.myALBProperties["targetgroupprotocol"]}"
	vpc_id = "${var.myVPCId}"

  health_check {
    path = "${var.myALBProperties["healthcheckpath"]}"
    healthy_threshold = 2
    unhealthy_threshold = 3
  }
}

resource "aws_alb_listener" "thisListener" {
	provider =  "aws.primary"	
    load_balancer_arn = "${aws_alb.myALB.arn}"
    port = "${var.myALBProperties["targetgroupport"]}"
    protocol = "${var.myALBProperties["targetgroupprotocol"]}"
    default_action {
    	target_group_arn = "${aws_alb_target_group.thisTG.arn}"
    	type = "forward"
    }
}
