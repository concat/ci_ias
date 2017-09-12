variable "myEIPQty" {}

output "eip_ids" { value = [ "${aws_eip.myEIPs4NatGateways.*.id}" ] }