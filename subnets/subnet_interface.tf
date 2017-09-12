variable "myVPCId" {}

variable "myGlobalTags" {
	type = "map"
}
variable "myApplicationTags" {
	type = "map"
}
variable "myEnvironmentTags" {
	type = "map"
}
variable "mySubnetProperties" {
	type = "list"
}

output "subnet_ids" { value = [ "${aws_subnet.mySubnets.*.id}" ] }
output "routetable_ids" { value = "${module.routetable.myRouteTableIds}" }
