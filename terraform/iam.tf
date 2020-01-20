# Role for Glue Crawler / Job
data "aws_iam_policy_document" "glue-role" {

  statement {
    effect = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["glue.amazonaws.com"]
    }
  }
}

# Policy for Glue Crawler / Job
data "aws_iam_policy_document" "glue-role_policy" {
  statement {
    effect = "Allow"
    actions = [
        "s3:Get*",
        "s3:List*",
        "s3:Put*",
        "s3:Delete*",
        "glue:*",
        "iam:List*",
        "iam:Get*",
        "iam:PassRole",
        "ec2:Describe*",
        "ec2:CreateTags",
        "ec2:DeleteTags",
        "ec2:RunInstances",
        "ec2:TerminateInstances",
        "tag:GetResources",
        "rds:Describe*",
        "cloudformation:Describe*",
        "cloudformation:Get*",
        "kms:ListAliases",
        "kms:DescribeKey",
        "cloudwatch:GetMetricData",
        "cloudwatch:ListDashboards",
        "cloudwatch:PutMetricData",
        "logs:GetLogEvents",
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "cloudformation:CreateStack",
        "cloudformation:DeleteStack"
    ]
    resources = [
      "*",
    ]
  }
}

# Glue Role
resource "aws_iam_role" "glue-role" {
  name               = "iamrole-${var.env}-glue"
  assume_role_policy = "${data.aws_iam_policy_document.glue-role.json}"
}

resource "aws_iam_role_policy" "glue-role_policy" {
  name   = "iampolicy-${var.env}-glue"
  role   = "${aws_iam_role.glue-role.id}"
  policy = "${data.aws_iam_policy_document.glue-role_policy.json}"
}