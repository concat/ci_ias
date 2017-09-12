resource "aws_autoscaling_group" "asg" {
	provider =  "aws.primary"
	#count = "${var.myASGQty}" 
	vpc_zone_identifier = [ "${var.mySubnetIds}" ]
	target_group_arns = [ "${var.myTGARNs}" ]

	health_check_type = "${var.myHealthCheckType}"
	launch_configuration = "${var.myLCId}"
	max_size = "${lookup(var.myASGSize, "max_size")}"
	desired_capacity = "${lookup(var.myASGSize, "desired_capacity")}"
	min_size = "${lookup(var.myASGSize, "min_size")}"
	
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