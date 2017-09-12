module "internal_subnetfactory" {
	source = "../subnets"
	myVPCId = "${var.myVPCId}"
	mySubnetProperties = "${var.mySubnetProperties}"
	myGlobalTags = "${var.myGlobalTags}"
	myApplicationTags = "${var.myApplicationTags}"
	myEnvironmentTags = "${var.myEnvironmentTags}"
}

module "natgateway_route" {
	source = "../natgateway_route"
	myRTQty = "${length(var.mySubnetProperties)}"
	myNATGatewayIds = "${var.myNATGatewayIds}"
	myRoutetableIds = "${module.internal_subnetfactory.routetable_ids}"		
}