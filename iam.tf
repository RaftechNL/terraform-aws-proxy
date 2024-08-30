module "iam_assumable_role_ssm" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  version = "v5.44.0"

  create_role             = var.create_role
  create_instance_profile = var.create_instance_profile


  role_name        = "${local.full_service_name}-role"
  role_description = "IAM Role for ${local.full_service_name}"

  role_requires_mfa = var.role_requires_mfa

  # https://aws.amazon.com/blogs/security/announcing-an-update-to-iam-role-trust-policy-behavior/
  allow_self_assume_role = var.allow_self_assume_role

  trusted_role_services = [
    "ec2.amazonaws.com"
  ]

  custom_role_policy_arns = concat(
    var.additional_iam_policies,
    [
      "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
    ]
  )

  tags = merge(
    {
    },
    local.tags_app_module
  )

}


data "aws_iam_policy_document" "this" {
  statement {
    sid       = "AllowStartSessionForEnv"
    effect    = "Allow"
    actions   = ["ssm:StartSession"]
    resources = ["arn:aws:ec2:*:*:instance/*"]
    condition {
      test     = "StringEquals"
      variable = "aws:ResourceTag/environment"
      values   = var.environment == "prd" ? ["prd"] : ["tst", "dev", "acc", "qa", "prv", "stg", "qas"]
    }
  }

  statement {
    sid       = "AllowPortForwardingViaDocument"
    effect    = "Allow"
    actions   = ["ssm:StartSession"]
    resources = ["arn:aws:ssm:*:*:document/AWS-StartPortForwardingSessionToRemoteHost"]
  }

  statement {
    sid       = "AllowResumeAndTerminateSession"
    effect    = "Allow"
    actions   = ["ssm:ResumeSession", "ssm:TerminateSession"]
    resources = ["arn:aws:ssm:*:*:session/*"]
  }
}

module "iam_policy_ssm_connect" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-policy"
  version = "v5.30.0"

  name        = "${local.full_service_name}-default"
  path        = "/"
  description = "IAM Policy for establishing ssm connection"

  policy = data.aws_iam_policy_document.this.json

  tags = merge(
    {
    },
    local.tags_app_module
  )
}
