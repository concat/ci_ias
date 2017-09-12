
resource "aws_route_table" "myRoutetable" {
	provider =  "aws.primary" 
    vpc_id = "${var.myVPCId}"
    count = "${var.routetableQty}"

    tags = "${merge(var.myGlobalTags,var.myApplicationTags,var.myEnvironmentTags,map("Name","${lookup(var.mySubnetProperties[count.index],"name")}"),map("Function","${lookup(var.mySubnetProperties[count.index],"function")}"))}"

}

module "rtassoc" {
	source = "./rtassoc"
	myRTAssocQty = "${var.routetableQty}"
	myRoutetablesId = "${aws_route_table.myRoutetable.*.id}"
	mySubnetsId = "${var.mySubnetsId}"
}

