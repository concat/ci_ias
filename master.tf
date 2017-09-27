module "vpc" {
	source = "./vpc"
	myVPCName = "${var.gnw-vpc-name}"
	myVPCCIDRBlock = "${var.gnw-vpc-cidr-block}"
	myIGWName = "${var.gnw-igw-name}"
	myGlobalTags = "${var.gnw-global-tags}"
	myApplicationTags = "${var.gnw-application-tags}"
	myEnvironmentTags = "${var.gnw-environment-tags}"
	myDomainName = "${var.gnw-domain-name}"
	myDNSServers = "${var.gnw-dns-servers}"
}

module "s3bucket" {
	source = "./s3bucket"
	myBucketProperties = "${var.s3bucket}"
}

module "the_igw" {
	source = "./igw"
	myVPCId = "${module.vpc.vpc_id}"
	mySubnetProperties = "${var.green_perim_subnets}"
	myGlobalTags = "${var.gnw-global-tags}"
	myApplicationTags = "${var.gnw-application-tags}"
	myEnvironmentTags = "${var.gnw-environment-tags}"	
}

# Mandatory - provides home for Presentation Tier ALB
module "green_perim_subnets" {
	source = "./perimsubnet"
	myVPCId = "${module.vpc.vpc_id}"
	myIGWId = "${module.the_igw.igw_id}"
	mySubnetProperties = "${var.green_perim_subnets}"
	myGlobalTags = "${var.gnw-global-tags}"
	myApplicationTags = "${var.gnw-application-tags}"
	myEnvironmentTags = "${var.gnw-environment-tags}"
}

# # Mandatory - per above
module "green_perim_nacl" {
	source = "./nacl"
	myVPCId = "${module.vpc.vpc_id}"
	mySubnets = "${module.green_perim_subnets.subnet_ids}"
	myNACLIngressRules = "${var.perim_nacl_ingress_rules}"
	myNACLEgressRules = "${var.perim_nacl_egress_rules}"
	myGlobalTags = "${var.gnw-global-tags}"
	myApplicationTags = "${var.gnw-application-tags}"
	myEnvironmentTags = "${var.gnw-environment-tags}"
}

module "green_pres_subnets" {
	source = "./internal-subnet-with-nat-and-endpoint"
	myVPCId = "${module.vpc.vpc_id}"	
	mySubnetProperties = "${var.green_pres_subnets}"
	myS3BucketRegion = "${var.s3bucket["region"]}"
	myGlobalTags = "${var.gnw-global-tags}"
	myApplicationTags = "${var.gnw-application-tags}"
	myEnvironmentTags = "${var.gnw-environment-tags}"
	myNATGatewayIds = "${module.green_perim_subnets.natgateway_ids}"
}

module "green_pres_nacl" {
	source = "./nacl"
	myVPCId = "${module.vpc.vpc_id}"
	mySubnets = "${module.green_pres_subnets.subnet_ids}"
	myNACLIngressRules = "${var.pres_nacl_ingress_rules}"
	myNACLEgressRules = "${var.pres_nacl_egress_rules}"
	myGlobalTags = "${var.gnw-global-tags}"
	myApplicationTags = "${var.gnw-application-tags}"
	myEnvironmentTags = "${var.gnw-environment-tags}"
}

# # Mandatory - no green and blue at this tier
module "data_subnets" {
	source = "./internal-subnet"
	myVPCId = "${module.vpc.vpc_id}"	
	mySubnetProperties = "${var.data_subnets}"
	myGlobalTags = "${var.gnw-global-tags}"
	myApplicationTags = "${var.gnw-application-tags}"
	myEnvironmentTags = "${var.gnw-environment-tags}"
}

# # Mandatory - see above
module "data_nacl" {
	source = "./nacl"
	myVPCId = "${module.vpc.vpc_id}"
	mySubnets = "${module.data_subnets.subnet_ids}"
	myNACLIngressRules = "${var.data_nacl_ingress_rules}"
	myNACLEgressRules = "${var.data_nacl_egress_rules}"
	myGlobalTags = "${var.gnw-global-tags}"
	myApplicationTags = "${var.gnw-application-tags}"
	myEnvironmentTags = "${var.gnw-environment-tags}"
}

module "iam_roles" {
	source = "./iam-roles"
	myBucketArn = "${module.s3bucket.bucket_arn}"
	myAWSAccountNumber = "${var.AWS-account-number}"
	mySMParameterStorePath = "${var.parameter_store_path}"
}

# Assumes SG is the same for green and blue
module "web_sg" {
	source = "./web-sg"
	myVPCId = "${module.vpc.vpc_id}"
	mySGName = "WebSecurityGroup-${lookup(var.gnw-application-tags, "Application Name")}"	
}

module "web_launch_config" {
	source = "./lc"
	myIAMInstanceProfileId = "${module.iam_roles.iam_web_instance_profile_id}"
	myImageId = "${var.web_image_id}"
	myApplicationName = "Web LC for ${lookup(var.gnw-application-tags, "Application Name")}"
	myInstanceType = "${var.web_instance_type}"
	myKeyPair = "${var.keypair}"
	mySGIds = [ "${module.web_sg.sg_id}" ]
}

# ALB shared across Green and Blue
module "web_green_alb" {
	source = "./alb"
	myALBProperties = "${var.web-green-alb-properties}"
	mySubnetIds = [ "${module.green_perim_subnets.subnet_ids[0]}", "${module.green_perim_subnets.subnet_ids[1]}" ]
	mySGIds = [ "${module.web_sg.sg_id}" ]
	myVPCId = "${module.vpc.vpc_id}" 
}

# # Register the application's domains in Route 53
module "app-domain-records" {
	source = "./route53-reg"
	myRoute53HostedZoneId = "${var.theRoute53ZoneId}"
	myALBDNSName = "${module.web_green_alb.alb_dns_name}"
	myALBZoneId = "${module.web_green_alb.alb_zone_id}"
	myFQDNs = "${var.application-domain-names}"
}

module "green_web_asg" {
	source = "./asg_with_name"
	myASGProperties = "${var.web_asg_properties}"
	myASGColor = "Green"
	myEC2Tags = "${var.web_ec2_tags}"
	myLCId = "${module.web_launch_config.lc_id}"
	myTGARNs = [ "${module.web_green_alb.default_target_group_arn}" ]
	mySubnetIds = "${module.green_pres_subnets.subnet_ids}"
}

module "data_sg" {
	source = "./data-sg"
	myVPCId = "${module.vpc.vpc_id}"
	mySGsAllowedIngress3306 = [ "${module.web_sg.sg_id}" ]
	mySGName = "DataSecurityGroup-${lookup(var.gnw-application-tags, "Application Name")}"	
}

module "rds" {
	source = "./rds"
	myRDSProperties = "${var.rds_properties}"
	myRDSDBPassword = "${var.rds_db_password}"
	myDBSubnetIds = "${module.data_subnets.subnet_ids}"
	mySGIds = [ "${module.data_sg.sg_id}" ]
}
