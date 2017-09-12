# variable "myAMI_Id_Filters" {
# 	type = "map"
# }
variable "myImageId" {}
variable "myInstanceType" {}
variable "myApplicationName" {}
variable "myKeyPair" {}
variable "myIAMInstanceProfileId" {}
#variable "myLCQty" {}
# variable "myStringColors" {
# 	type = "list"
# }
variable "mySGIds" {
	type = "list"
}
#variable "myAMIId" {}
#variable "myInstanceType" {}

output "lc_id" { value = "${aws_launch_configuration.lc.id}" }
