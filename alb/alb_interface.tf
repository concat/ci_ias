variable "myALBProperties" {
  type = "map"
}
variable "mySubnetIds" {
	type = "list"
}
variable "mySGIds" {
	type = "list"
}
variable "myVPCId" {}

output "alb_name" { value = "${aws_alb.myALB.name}" }
output "alb_dns_name" { value = "${aws_alb.myALB.dns_name}" }
output "alb_zone_id" { value = "${aws_alb.myALB.zone_id}" }
output "default_target_group_arn" { value = [ "${aws_alb_target_group.thisTG.arn}" ]}
