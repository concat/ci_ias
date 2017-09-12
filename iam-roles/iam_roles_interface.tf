variable myBucketArn {
  type = "string"
}
variable myAWSAccountNumber {
  type = "string"
}
variable mySMParameterStorePath {
  type = "string"
}

output "iam_web_instance_profile_id" { value = "${aws_iam_instance_profile.myWebInstanceProfile.id}" }