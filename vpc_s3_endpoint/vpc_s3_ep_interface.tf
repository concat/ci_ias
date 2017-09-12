variable "myVPCId" {}
variable "myS3BucketRegion" {}
variable "myRoutetableIds" {
  type = "list"
}

output "vpc_endpoint_id" { value = "${aws_vpc_endpoint.private-s3.id}" }