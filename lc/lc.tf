# data "aws_ami" "web-ami" {
# 	provider =  "aws.${var.myProviderInfo["primary_alias"]}"

# 	most_recent = true
# 	owners = ["self"]
# 	filter {
# 	  name = "tag:Application"
# 	  values = ["GNW"]
# 	}
# 	filter {
# 	  name = "tag:Sprint Version"
# 	  values = ["0.0"]
# 	}
# 	filter {
# 		name = "tag:Env" 
# 		values = ["Base"]
# 	}
# 	filter {
# 	  name = "tag:Tier"
# 	  values = ["Any"]
# 	}
# }


# output "ami_msg" {
#     value = "The AMI Id is ${data.aws_ami.web-ami.id}"
# }

# resource "template_file" "my_user_data" {
# 	template = "userdata-script.tpl"
# 	# lifecycle {
# 	# 	create_before_destroy = true
# 	# }
# }

resource "aws_launch_configuration" "lc" {
	provider =  "aws.primary"
# name = "${var.myApplicationName}"
#    image_id = "${data.aws_ami.web-ami.id}"

  image_id = "${var.myImageId}"
	instance_type = "${var.myInstanceType}"
  iam_instance_profile = "${var.myIAMInstanceProfileId}"
	user_data = <<HEREDOC
#!/bin/bash
# Install needed packages to enable this Centos image for ansible-pull and use of an IAM profile
yum install epel-release -y
yum install awscli -y
yum install ansible -y
yum install git -y
ansible-pull -U https://github.com/concat/ansible-playbooks --full codeigniter-base.yml
ansible-pull -U https://github.com/concat/ansible-playbooks --full ci_apps.yml
HEREDOC

#	iam_instance_profile = "${var.myIAMCodeDeployId}"
  associate_public_ip_address = false
	security_groups = [ "${var.mySGIds}" ]
	key_name = "${var.myKeyPair}"
}