variable "myVPCId" {}
variable "myIGWId" {}

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

output "subnet_ids" { value = [ "${module.prsubnetfactory.subnet_ids}" ] }
output "natgateway_ids" { value = [ "${module.nat_gateway.natgateway_ids}" ] }