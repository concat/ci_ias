# VPC Modules Variables and Outputs

# Variables (inputs to module)

variable "myNACLId" {}
variable "myNACLRules" {
	type = "list"
}
variable "myNACLRulesForEgress" {}