resource "aws_autoscaling_group" "asg" {
	provider =  "aws.primary"
	name = "${var.myASGProperties["asg_base_name"]}${var.myASGColor}"
	vpc_zone_identifier = [ "${var.mySubnetIds}" ]
	target_group_arns = [ "${var.myTGARNs}" ]

	health_check_type = "${var.myASGProperties["health_check_type"]}"
	launch_configuration = "${var.myLCId}"
	max_size = "${var.myASGProperties["max_size"]}"
	desired_capacity = "${var.myASGProperties["desired_capacity"]}"
	min_size = "${var.myASGProperties["min_size"]}"
	
    tag {
		key = "TierBundle"
		value = "${lookup(var.myEC2Tags, "TierBundle")}"
		propagate_at_launch = true
	}
	tag {
		key = "Application"
		value = "${lookup(var.myEC2Tags, "ApplicationName")}"
		propagate_at_launch = true
	}
	tag {
		key = "ASGColor"
		value = "${var.myASGColor}"
		propagate_at_launch = true
	}
	
}