module "internal_subnetfactory" {
	source = "../subnets"
	myVPCId = "${var.myVPCId}"
	mySubnetProperties = "${var.mySubnetProperties}"
	myGlobalTags = "${var.myGlobalTags}"
	myApplicationTags = "${var.myApplicationTags}"
	myEnvironmentTags = "${var.myEnvironmentTags}"
}
