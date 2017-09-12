

resource "aws_subnet" "mySubnets" {
    count = "${length(var.mySubnetProperties)}"
 provider =  "aws.primary" 
    vpc_id = "${var.myVPCId}"
 
    cidr_block              = "${lookup(var.mySubnetProperties[count.index],"cidr_block")}"
    availability_zone       = "${lookup(var.mySubnetProperties[count.index],"availability_zone")}"
    map_public_ip_on_launch = "${lookup(var.mySubnetProperties[count.index],"map_public_ip_on_launch")}"
 
    tags = "${merge(var.myGlobalTags,var.myApplicationTags,var.myEnvironmentTags,map("Name","${lookup(var.mySubnetProperties[count.index],"name")}"),map("Function","${lookup(var.mySubnetProperties[count.index],"function")}"))}"

}

module "routetable" {
	source = "../routetable" 
#	mySubnetsId = [ "${aws_subnet.mySubnets.*.id}" ]
  mySubnetsId = "${aws_subnet.mySubnets.*.id}"
	#mySubnetsAZ = [ "${aws_subnet.mySubnets.*.availability_zone}" ]
	routetableQty = "${length(var.mySubnetProperties)}" # creating a routetable for each subnet
# routetableQty = 2
	myVPCId = "${var.myVPCId}"
	mySubnetProperties = "${var.mySubnetProperties}"
  myGlobalTags = "${var.myGlobalTags}"
	myApplicationTags = "${var.myApplicationTags}"
	myEnvironmentTags = "${var.myEnvironmentTags}"
}