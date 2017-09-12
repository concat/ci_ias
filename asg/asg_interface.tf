variable "myASGSize" {
	type = "map"
}
variable "myHealthCheckType" {
	type = "string"
}
variable "myEC2Tags" {
	type = "map"
}
variable "myASGColor" {}
variable "myLCId" {}
variable "mySubnetIds" {
	type = "list"
}

variable "myTGARNs" {
	type = "list"
}

output "asg_id" { value = [ "${aws_autoscaling_group.asg.id}" ] }
