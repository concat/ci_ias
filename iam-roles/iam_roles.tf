#
# The following three resources needed for instances using Code Deploy to grab code from s3 buckets
#
resource "aws_iam_role" "assume_role" {
	provider =  "aws.primary" 
	assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
     {
        "Effect": "Allow",
        "Principal": {
           "Service": [
               "ec2.amazonaws.com"
           ]
        },
        "Action": "sts:AssumeRole"
      }
   ]
}
EOF

}

resource "aws_iam_role_policy" "ec2access2s3" {
	provider =  "aws.primary" 
	role = "${aws_iam_role.assume_role.id}"

	policy = <<ANOTHER
{
  "Version": "2012-10-17",
  "Statement": [
     {
         "Action": [
            "s3:ListAllMyBuckets",
            "s3:GetBucketLocation"
         ],
         "Effect": "Allow",
         "Resource": "arn:aws:s3:::*"
      },
      {
         "Action": [
            "s3:ListBucket"
         ],
         "Effect": "Allow",
         "Resource": "${var.myBucketArn}"
      },
      {
         "Action": [
            "s3:GetObject",
            "s3:PutObject",
            "s3:DeleteObject"
         ],
         "Effect": "Allow",
         "Resource": "${var.myBucketArn}/*"
      },
      {
         "Action": [
            "ssm:GetParameters"
         ],
         "Effect": "Allow",
         "Resource": "arn:aws:ssm:us-east-1:${var.myAWSAccountNumber}:parameter/${var.mySMParameterStorePath}*"
      },
      {
        "Action": [
           "autoscaling:DescribeAutoScalingGroups",
           "autoscaling:DescribeAutoScalingInstances",
           "ec2:DescribeInstances"
        ],
        "Effect": "Allow",
        "Resource": "*"
      }
   ]
}
ANOTHER

}

resource "aws_iam_instance_profile" "myWebInstanceProfile" {
  provider =  "aws.primary"  
  role = "${aws_iam_role.assume_role.name}"
}
