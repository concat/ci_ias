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

#Working on this code
module "vpc_s3_endpoint" {
	source = "../vpc_s3_endpoint"
	myVPCId = "${var.myVPCId}"
	myS3BucketRegion = "${var.myS3BucketRegion}"
	myRoutetableIds = "${module.internal_subnetfactory.routetable_ids}"
}