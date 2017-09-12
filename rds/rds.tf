resource "aws_db_subnet_group" "default" {
  provider = "aws.primary"

  subnet_ids = [ "${var.myDBSubnetIds}" ]

  # tags {
  #   Name = "My DB subnet group"
  # }
}

resource "aws_db_instance" "myDB" {
  provider = "aws.primary"

  allocated_storage    = "${var.myRDSProperties["allocated_storage"]}"
  storage_type         = "${var.myRDSProperties["storage_type"]}"
  storage_encrypted    = "${var.myRDSProperties["storage_encrypted"]}"
  engine               = "${var.myRDSProperties["engine"]}"
  engine_version       = "${var.myRDSProperties["engine_version"]}"
  instance_class       = "${var.myRDSProperties["instance_class"]}"
  identifier           = "${var.myRDSProperties["identifier"]}"
  name                 = "${var.myRDSProperties["db_dbname"]}"
  username             = "${var.myRDSProperties["db_username"]}"
  password             = "${var.myRDSDBPassword}"
  db_subnet_group_name = "${aws_db_subnet_group.default.id}"
  multi_az             = "${var.myRDSProperties["multi_az"]}"
  vpc_security_group_ids   = [ "${var.mySGIds}" ]
#  parameter_group_name = "default.mysql5.6"
}