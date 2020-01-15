resource "aws_iam_role" "CloudWatchAgentServerRole-2" {
  name = "CloudWatchAgentServerRole-2"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_instance_profile" "CloudWatchAgentServerRole-instanceprofile" {
  name = "CloudWatchAgentServerRoleProfile"
  role = "${aws_iam_role.CloudWatchAgentServerRole-2.name}"
}

resource "aws_iam_role_policy" "CloudWatchAgentServerRole-policy" {
  name = "CloudWatchAgentServerPolicy"
  role = "${aws_iam_role.CloudWatchAgentServerRole-2.id}"
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "cloudwatch:PutMetricData",
                "ec2:DescribeTags",
                "logs:PutLogEvents",
                "logs:DescribeLogStreams",
                "logs:DescribeLogGroups",
                "logs:CreateLogStream",
                "logs:CreateLogGroup"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "ssm:GetParameter"
            ],
            "Resource": "arn:aws:ssm:*:*:parameter/AmazonCloudWatch-*"
        }
    ]
}
EOF
}

