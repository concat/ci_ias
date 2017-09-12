module "prsubnetfactory" {
	source = "../subnets"
	myVPCId = "${var.myVPCId}"
	mySubnetProperties = "${var.mySubnetProperties}"
	myGlobalTags = "${var.myGlobalTags}"
	myApplicationTags = "${var.myApplicationTags}"
	myEnvironmentTags = "${var.myEnvironmentTags}"
}

module "eip" {
	source = "../eip"
	myEIPQty = "${length(var.mySubnetProperties)}"	
}

module "nat_gateway" {
	source = "../natgateway"
	eipList = "${module.eip.eip_ids}"
	natQty = "${length(var.mySubnetProperties)}"	# need a NAT Gateway for each perimeter subnet
	natSubnets = "${module.prsubnetfactory.subnet_ids}"
}

# resource "aws_internet_gateway" "intgw" {
# 	provider =  "aws.${var.myProviderInfo["primary_alias"]}" 
# 	vpc_id = "${var.myVPCId}"

#     tags = "${merge(var.myGlobalTags,var.myApplicationTags,var.myEnvironmentTags,map("Name","${lookup(var.mySubnetProperties[count.index],"name")}"),map("Function","${lookup(var.mySubnetProperties[count.index],"function")}"))}"
# }

module "igw_route" {
	source = "../igw_route"
	myRTQty = "${length(var.mySubnetProperties)}"
	myRoutetableIds = "${module.prsubnetfactory.routetable_ids}"
	myIGWId = "${var.myIGWId}"
}

