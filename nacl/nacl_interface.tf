variable "myVPCId" {}
variable "mySubnets" {
	type = "list"
}
variable "myNACLIngressRules" {
	type = "list"
}
variable "myNACLEgressRules" {
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

output "nacl_id" { value = "${aws_network_acl.myNACL.id}" }