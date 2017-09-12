variable "eipList" {
	type = "list"
}
variable "natQty" {}
variable "natSubnets" {
	type = "list"
}

output "natgateway_ids" { value = [ "${aws_nat_gateway.myNatGateways.*.id}" ] }