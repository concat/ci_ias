resource "aws_internet_gateway" "intgw" {
	provider =  "aws.primary" 
	vpc_id = "${var.myVPCId}"

    tags = "${merge(var.myGlobalTags,var.myApplicationTags,var.myEnvironmentTags,map("Name","${lookup(var.mySubnetProperties[count.index],"name")}"),map("Function","${lookup(var.mySubnetProperties[count.index],"function")}"))}"
}