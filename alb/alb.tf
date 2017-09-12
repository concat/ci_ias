resource "aws_alb" "myALB" {
	provider =  "aws.primary"
	name = "${var.myALBName}"
	subnets = [ "${var.mySubnetIds}" ]
	security_groups = [ "${var.mySGIds}" ]

	internal = "${var.myALBInternalFlag}"
}

resource "aws_alb_target_group" "thisTG" {
	provider =  "aws.primary"	
	name = "${var.myALBTargetGroupName}"
	port = 80
	protocol = "HTTP"
	vpc_id = "${var.myVPCId}"

  health_check {
    path = "/xyz/index.php/"
    healthy_threshold = 2
    unhealthy_threshold = 3
  }
}

resource "aws_alb_listener" "thisListener" {
	provider =  "aws.primary"	
    load_balancer_arn = "${aws_alb.myALB.arn}"
    port = 80
    protocol = "HTTP"
    default_action {
    	target_group_arn = "${aws_alb_target_group.thisTG.arn}"
    	type = "forward"
    }
}
