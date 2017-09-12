resource "aws_network_acl_rule" "naclrule" {
	provider =  "aws.primary" 
	network_acl_id = "${var.myNACLId}"
	count = "${length(var.myNACLRules)}"

	rule_number = "${lookup(var.myNACLRules[count.index],"rule_no")}"
	egress = "${var.myNACLRulesForEgress}"
	protocol = "${lookup(var.myNACLRules[count.index],"protocol")}"
	rule_action = "${lookup(var.myNACLRules[count.index],"action")}"
	cidr_block = "${lookup(var.myNACLRules[count.index],"cidr_block")}"
	from_port = "${lookup(var.myNACLRules[count.index],"from_port")}"
	to_port = "${lookup(var.myNACLRules[count.index],"to_port")}"

}