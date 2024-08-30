variable "app_name" {
  description = "Name of the application"
  type        = string
  default     = "ssm-proxy"
}

variable "create" {
  type        = bool
  description = "Controls if the resources are created or not"
}

variable "project" {
  type        = string
  description = "Name of the project"
}

variable "environment" {
  type        = string
  description = "Name of the environment (i.e.: prd, acc, dev, test)"
  validation {
    condition     = contains(["prd", "acc", "dev", "tst", "prv", "stg", "qas"], var.environment)
    error_message = "The environment needs to be in prod, acc, dev, test, preview."
  }
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to add to all resources created by this module"
  default     = {}
}

variable "vpc_id" {
  type        = string
  description = "VPC id where the resources will be deployed"
}
variable "vpc_zone_identifier" {
  description = "A list of subnet IDs to launch resources in ( ASG )"
  type        = list(string)
  default     = []
}

variable "create_role" {
  type        = bool
  description = "Controls if the role is created or not"
  default     = true
}

variable "create_instance_profile" {
  type        = bool
  description = "Controls if the instance profile is created or not"
  default     = true
}


variable "role_requires_mfa" {
  type        = bool
  description = "Controls if the role requires MFA or not"
  default     = false
}

variable "instance_type" {
  type        = string
  description = "The type of instance to start"
  default     = "t3.micro"
}

variable "allow_self_assume_role" {
  type        = bool
  description = "Controls if the role allows self-assume or not"
  default     = true
}

variable "ami_filter" {
  type = object({
    filter_name = string,
    owner       = string,
  })

  default = {
    filter_name = "amzn2-ami-kernel-5.10-hvm-2.0.20220912.1-x86_64-gp2"
    owner       = "137112412989"
  }

  description = "Defines query params for AMI"
}

variable "security_group_rules" {
  description = "Map of security group rules to add to the ec2 security group instance"
  type        = any
  default     = {}
}

variable "user_data" {
  description = "User data to be used in the EC2 instance"
  type        = string
  default     = ""
}

variable "schedules" {
  description = "Map of schedules to add to the autoscaling group"
  type        = any
  default     = {}
}

variable "additional_iam_policies" {
  description = "List of additional IAM policies to attach to the role"
  type        = list(string)
  default     = []
}