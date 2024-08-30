output "iam_policy" {
  description = "IAM Policy for establishing ssm connection"
  value = {
    "default" : {
      "id" : module.iam_policy_ssm_connect.id,
      "arn" : module.iam_policy_ssm_connect.arn,
      "name" : module.iam_policy_ssm_connect.name,
      "path" : module.iam_policy_ssm_connect.path,
    }
  }
}