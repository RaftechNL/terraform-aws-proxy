resource "aws_security_group" "this" {

  description = "Security group allowing access to resources via AWS SSM"
  vpc_id      = var.vpc_id
  name        = local.full_service_name

  tags = local.tags_app_module
}

resource "aws_security_group_rule" "default" {

  type              = "egress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "To reach SSM required endpoints"
  security_group_id = aws_security_group.this.id

}


resource "aws_security_group_rule" "this" {
  for_each = { for k, v in var.security_group_rules : k => v }

  type              = try(each.value.type, "ingress")
  from_port         = try(each.value.from_port, "443")
  to_port           = try(each.value.to_port, "443")
  protocol          = try(each.value.protocol, "tcp")
  security_group_id = aws_security_group.this.id

  # optional
  cidr_blocks              = try(each.value.cidr_blocks, null)
  description              = try(each.value.description, null)
  ipv6_cidr_blocks         = try(each.value.ipv6_cidr_blocks, null)
  prefix_list_ids          = try(each.value.prefix_list_ids, null)
  source_security_group_id = try(each.value.source_security_group_id, null)
}
