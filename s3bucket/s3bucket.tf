resource "aws_s3_bucket" "myBucket" {
  provider = "aws.primary"

  bucket = "${var.myBucketProperties["name"]}"
  region = "${var.myBucketProperties["region"]}"

  versioning {
    enabled = "${var.myBucketProperties["isVersioned"]}"
  }
}