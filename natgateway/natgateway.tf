
resource "aws_nat_gateway" "myNatGateways" {
	provider =  "aws.primary" 
	count = "${var.natQty}"

	allocation_id = "${var.eipList[count.index]}"
	subnet_id = "${var.natSubnets[count.index]}"
}