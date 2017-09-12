variable "myVPCId" {}
variable "mySGName" {}

output "sg_id" { value = "${aws_security_group.sgWebTier.id}" }