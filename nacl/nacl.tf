resource "aws_network_acl" "myNACL" {
	provider =  "aws.primary"

  vpc_id = "${var.myVPCId}"

	subnet_ids = [ "${var.mySubnets}" ]
}

module "perim_nacl_ingress" {
	source = "./nacl_rules"
	myNACLId = "${aws_network_acl.myNACL.id}"
	#myRuleQty = "${length(var.myNACLIngressRules)}"
	myNACLRules = "${var.myNACLIngressRules}"
	myNACLRulesForEgress = "false"

}

module "perim_nacl_egress" {
	source = "./nacl_rules"
	myNACLId = "${aws_network_acl.myNACL.id}"
	#myRuleQty = "${length(var.nacl_egress_rules)}"
	myNACLRules = "${var.myNACLEgressRules}"
	myNACLRulesForEgress = "true"

}
