#!/bin/bash
# Install needed packages to enable this Centos image for ansible-pull and use of an IAM profile
yum install epel-release -y
yum install awscli -y
yum install ansible -y 
