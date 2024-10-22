locals {
  user_data = var.user_data != "" ? var.user_data : <<-EOT
    #!/bin/bash
    echo "Hello Terraform!"
  EOT
}

data "aws_ami" "amazon_linux" {
  most_recent = true

  filter {
    name   = "name"
    values = [var.ami_filter.filter_name]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = [var.ami_filter.owner] # the current account
}

module "asg" {
  source  = "terraform-aws-modules/autoscaling/aws"
  version = "v6.10.0"

  # Autoscaling group
  name = local.full_service_name

  vpc_zone_identifier = var.vpc_zone_identifier # module.vpc.private_subnets

  min_size         = 1
  max_size         = 1
  desired_capacity = 1

  # Launch template
  create_launch_template      = true
  launch_template_name        = local.full_service_name
  launch_template_description = "Launch template for SSM proxy hosts"
  update_default_version      = true
  image_id                    = data.aws_ami.amazon_linux.id
  instance_type               = var.instance_type # "t3.micro"
  user_data                   = base64encode(local.user_data)


  # instance profile setup
  create_iam_instance_profile = false # as we need to use our own precreated instance profile 
  iam_instance_profile_arn    = module.iam_assumable_role_ssm.iam_instance_profile_arn

  # Security setup
  security_groups = [aws_security_group.this.id]

  # Autoscaling Schedule
  schedules = var.schedules

  # tags 
  tag_specifications = [
    {
      resource_type = "instance"
      tags          = local.tags_app_module
    },
    {
      resource_type = "volume"
      tags          = local.tags_app_module
    },
    # {
    #   resource_type = "spot-instances-request"
    #   tags          = merge({ WhatAmI = "SpotInstanceRequest" })
    # }
  ]

  tags = merge(
    {},
    local.tags_app_module
  )
}


