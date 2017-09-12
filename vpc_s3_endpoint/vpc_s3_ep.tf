resource "aws_vpc_endpoint" "private-s3" {
  provider = "aws.primary"

  vpc_id = "${var.myVPCId}"
  service_name = "com.amazonaws.${var.myS3BucketRegion}.s3"
  route_table_ids = [ "${var.myRoutetableIds}" ]
  
}