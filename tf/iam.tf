resource "aws_iam_role" "insights-loadtest" {
  name_prefix = var.name_prefix
  description = "instance profile role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "insights-loadtest_s3" {
  name = "insights-loadtest-s3"
  role = aws_iam_role.insights-loadtest.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
  {
    "Sid": "AllowListBuckets",
    "Action": [
      "s3:ListBucket"
    ],
    "Resource": [
      "${aws_s3_bucket.data_exchange.arn}"
    ],
    "Effect": "Allow"
  },
  {
    "Sid": "ReadAccessToBucket",
    "Action": [
      "s3:GetObject"
    ],
    "Resource": [
      "${aws_s3_bucket.data_exchange.arn}/*"
    ],
    "Effect": "Allow"
  }
  ]
}
EOF

}

resource "aws_iam_instance_profile" "insights-loadtest" {
  name_prefix = var.name_prefix
  role        = aws_iam_role.insights-loadtest.name
}

