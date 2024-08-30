# terraform-aws-proxy
Repository containing code for terraform-aws-proxy

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.0.0, <2.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | = 5.65.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.65.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_asg"></a> [asg](#module\_asg) | terraform-aws-modules/autoscaling/aws | v6.10.0 |
| <a name="module_iam_assumable_role_ssm"></a> [iam\_assumable\_role\_ssm](#module\_iam\_assumable\_role\_ssm) | terraform-aws-modules/iam/aws//modules/iam-assumable-role | v5.44.0 |
| <a name="module_iam_policy_ssm_connect"></a> [iam\_policy\_ssm\_connect](#module\_iam\_policy\_ssm\_connect) | terraform-aws-modules/iam/aws//modules/iam-policy | v5.44.0 |

## Resources

| Name | Type |
|------|------|
| [aws_security_group.this](https://registry.terraform.io/providers/hashicorp/aws/5.65.0/docs/resources/security_group) | resource |
| [aws_security_group_rule.default](https://registry.terraform.io/providers/hashicorp/aws/5.65.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.this](https://registry.terraform.io/providers/hashicorp/aws/5.65.0/docs/resources/security_group_rule) | resource |
| [aws_ami.amazon_linux](https://registry.terraform.io/providers/hashicorp/aws/5.65.0/docs/data-sources/ami) | data source |
| [aws_iam_policy_document.this](https://registry.terraform.io/providers/hashicorp/aws/5.65.0/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_iam_policies"></a> [additional\_iam\_policies](#input\_additional\_iam\_policies) | List of additional IAM policies to attach to the role | `list(string)` | `[]` | no |
| <a name="input_allow_self_assume_role"></a> [allow\_self\_assume\_role](#input\_allow\_self\_assume\_role) | Controls if the role allows self-assume or not | `bool` | `true` | no |
| <a name="input_ami_filter"></a> [ami\_filter](#input\_ami\_filter) | Defines query params for AMI | <pre>object({<br>    filter_name = string,<br>    owner       = string,<br>  })</pre> | <pre>{<br>  "filter_name": "amzn2-ami-kernel-5.10-hvm-2.0.20220912.1-x86_64-gp2",<br>  "owner": "137112412989"<br>}</pre> | no |
| <a name="input_app_name"></a> [app\_name](#input\_app\_name) | Name of the application | `string` | `"ssm-proxy"` | no |
| <a name="input_create_instance_profile"></a> [create\_instance\_profile](#input\_create\_instance\_profile) | Controls if the instance profile is created or not | `bool` | `true` | no |
| <a name="input_create_role"></a> [create\_role](#input\_create\_role) | Controls if the role is created or not | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Name of the environment (i.e.: prd, acc, dev, test) | `string` | n/a | yes |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | The type of instance to start | `string` | `"t3.micro"` | no |
| <a name="input_project"></a> [project](#input\_project) | Name of the project | `string` | n/a | yes |
| <a name="input_role_requires_mfa"></a> [role\_requires\_mfa](#input\_role\_requires\_mfa) | Controls if the role requires MFA or not | `bool` | `false` | no |
| <a name="input_schedules"></a> [schedules](#input\_schedules) | Map of schedules to add to the autoscaling group | `any` | `{}` | no |
| <a name="input_security_group_rules"></a> [security\_group\_rules](#input\_security\_group\_rules) | Map of security group rules to add to the ec2 security group instance | `any` | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources created by this module | `map(string)` | `{}` | no |
| <a name="input_user_data"></a> [user\_data](#input\_user\_data) | User data to be used in the EC2 instance | `string` | `""` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC id where the resources will be deployed | `string` | n/a | yes |
| <a name="input_vpc_zone_identifier"></a> [vpc\_zone\_identifier](#input\_vpc\_zone\_identifier) | A list of subnet IDs to launch resources in ( ASG ) | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_iam_policy"></a> [iam\_policy](#output\_iam\_policy) | IAM Policy for establishing ssm connection |
<!-- END_TF_DOCS -->
