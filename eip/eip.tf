resource "aws_eip" "myEIPs4NatGateways" {
	provider =  "aws.primary" 
	count = "${var.myEIPQty}"
	vpc = "true"
}