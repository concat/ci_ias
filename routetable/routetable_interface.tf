variable "myVPCId" {}
variable "routetableQty" {}
variable "mySubnetsId" {
	type = "list"
}
# variable "mySubnetsAZ" {
# 	type = "list"
# }
#variable "myRoutetableFile" {}
variable "mySubnetProperties" {
	type = "list"
}
variable "myGlobalTags" {
	type = "map"
}
variable "myApplicationTags" {
	type = "map"
}
variable "myEnvironmentTags" {
	type = "map"
}

# The below is a kluge - the output from this module not needed - it allows reference by index within the module
output "myRouteTableIds" { value = [ "${aws_route_table.myRoutetable.*.id}" ] }
