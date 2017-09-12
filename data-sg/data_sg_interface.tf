variable "myVPCId" {}
variable "mySGName" {}
variable "mySGsAllowedIngress3306" {
  type = "list"
}

output "sg_id" { value = "${aws_security_group.sgDataTier.id}" }