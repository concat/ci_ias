#
# AWS Account Number needed for certain ARNs
variable AWS-account-number {
  default = "124700617204"
}

# Global Tags
variable "gnw-global-tags" {
  type = "map"
 
  default = {
    terraform = "true"
  }
}
 
#Application Tags
variable "gnw-application-tags" {
  type = "map"
 
  default = {
    "Project Name"        = "DDBCorp Migration POC"
    "Application Name"     = "DDBCorp CI Apps"
    "Project Code"         = "12345"
    "Business Unit"        = "DDB"
    "Service Owner Suppor" = "beckstep@amazon.com"
    Requestor              = "beckstep@amazon.com"
    terraform              = "true"
  }
}
 
#Environment Tags
variable "gnw-environment-tags" {
  type = "map"
 
  default = {
    Environment = "poc"
  }
}

# VPC VARIABLES
variable "gnw-vpc-cidr-block" {
  default = "10.0.0.0/16"
}

variable "gnw-vpc-name" {
  default = "DDBCORPPOCTFMOD"
}

variable "s3bucket" {
  type = "map"
  default = {
    "region" = "us-east-1"
    "name" = "ddbcorputil"
  }

}

variable "gnw-igw-name" {
  default = "DDBCORPPOC-IGW"
}

variable "gnw-dns-servers" {
  default = [
     "AmazonProvidedDNS"
  ]
}
variable "gnw-domain-name" {
  default = "ec2.internal"
}

#Hosted Zone created in advance
variable "theRoute53ZoneId" {
  default = "Z1OQ3QXIRV9NBX"
}

variable "application-domain-names" {
  default = [
    "www.rstephenbeck.club",
    "test.rstephenbeck.club"
  ]
}

variable "parameter_store_path" {
  default = "DDBCorp/CI_Apps"
}
# SUBNET VARIABLES

# Green and Blue (if used) must have their first subnets for perim tier in different availability_zones
# for ALB Load balancing to succeed
variable "green_perim_subnets" {
  default = [
    {
      function                = "perimeter"
      name                    = "ddbcorp.poc.perimeter.a"
      availability_zone       = "us-east-1a"
      cidr_block              = "10.0.1.16/28"
      map_public_ip_on_launch = "FALSE"
    },
    {
      function                = "perimeter"
      name                    = "ddbcorp.poc.perimeter.b"
      availability_zone       = "us-east-1b"
      cidr_block              = "10.0.1.32/28"
      map_public_ip_on_launch = "FALSE"
    }   
  ]
}

variable "green_pres_subnets" {
  default = [
    {
      function                = "presentation"
      name                    = "ddbcorp.poc.presentation.a"
      availability_zone       = "us-east-1a"
      cidr_block              = "10.0.2.0/24"
      map_public_ip_on_launch = "FALSE"
    },
    {
      function                = "presentation"
      name                    = "ddbcorp.poc.presentation.b"
      availability_zone       = "us-east-1b"
      cidr_block              = "10.0.3.0/24"
      map_public_ip_on_launch = "FALSE"
    }
  ]
}



variable "data_subnets" {
  default = [
    {
      function                = "data"
      name                    = "ddbcorp.poc.data.a"
      availability_zone       = "us-east-1a"
      cidr_block              = "10.0.1.80/28"
      map_public_ip_on_launch = "FALSE"
    },
    {
      function                = "data"
      name                    = "ddbcorp.poc.data.b"
      availability_zone       = "us-east-1b"
      cidr_block              = "10.0.1.96/28"
      map_public_ip_on_launch = "FALSE"
    }
  ]
}

# NACL VARIABLES
variable "perim_nacl_ingress_rules" {
  default = [
    {
      protocol = "all"
      action = "allow"
      rule_no = 100
      from_port = 0
      to_port = 0
      cidr_block = "0.0.0.0/0"
    }
  ]
}

variable "perim_nacl_egress_rules" {
  default = [
    {
      protocol = "all"
      action = "allow"
      rule_no = 100
      from_port = 0
      to_port = 0
      cidr_block = "0.0.0.0/0"
    }
  ]
}

variable "pres_nacl_ingress_rules" {
  default = [
    {
      protocol = "all"
      action = "allow"
      rule_no = 100
      from_port = 0
      to_port = 0
      cidr_block = "0.0.0.0/0"
    }
  ]
}

variable "pres_nacl_egress_rules" {
  default = [
    {
      protocol = "all"
      action = "allow"
      rule_no = 100
      from_port = 0
      to_port = 0
      cidr_block = "0.0.0.0/0"
    }
  ]
}

variable "data_nacl_ingress_rules" {
  default = [
    {
      protocol = "all"
      action = "allow"
      rule_no = 100
      from_port = 0
      to_port = 0
      cidr_block = "0.0.0.0/0"
    }
  ]
}

variable "data_nacl_egress_rules" {
  default = [
    {
      protocol = "all"
      action = "allow"
      rule_no = 100
      from_port = 0
      to_port = 0
      cidr_block = "0.0.0.0/0"
    }
  ]
}

# Web Tier Configuration
# ALB VARIABLES
variable "web-green-alb-properties" {
  type = "map"
  default = {
    albname = "DDBCorp-Web-Green-ALB"
    healthcheckpath = "/xyz/index.php/"
    targetgroupname = "DDBCorp-Web-ALB"
    targetgroupport = 80
    targetgroupprotocol = "HTTP"
    internalLB = false
  }
}

# #Launch Configuration VARIABLES
# variable "web_ami_id_filters" {
#   type = "map"
#   default =  {
#     appname = "GNW"
#     sprintnumber = "0.0"
#     environment = "Base"
#     TierBundle = "Generic"
#   }
# }

variable "web_image_id" { 
  default = "ami-46c1b650"
}

variable "web_instance_type" {
  default = "t2.small"
}

variable "web_ec2_tags" {
  type = "map"
  default = {
    TierBundle = "web"
    ApplicationName = "DDBCorp WebApps"
  }
}

# Change for your EC2 Keypair
variable "keypair" {
  default = "Beckstep1-East-Keypair"
}

variable "web_asg_properties" {
  type = "map"
  default = {
    max_size = 1
    desired_capacity = 1
    min_size = 1
    health_check_type = "ELB"
    asg_base_name = "DDBCorpWebASG"
  }
}

variable "rds_properties" {
  type = "map"
  default = {
    instance_class = "db.t2.small"
    multi_az = false
    identifier = "ddbrdsmysql"
    allocated_storage = 10
    storage_type = "gp2"
    storage_encrypted = true
    engine = "mysql"
    engine_version = "5.6.35"
    db_username = "ddbsqladmin"
    db_dbname = "citutorial"
  }
}

# This will require entry of the database password
variable "rds_db_password" {
  type = "string"
}


