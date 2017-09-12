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

output "igw_id" { value = "${aws_internet_gateway.intgw.id}" }