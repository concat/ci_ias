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

output "subnet_ids" { value = [ "${module.internal_subnetfactory.subnet_ids}" ] }