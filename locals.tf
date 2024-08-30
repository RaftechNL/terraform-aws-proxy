locals {
  resource_prefix = "${var.project}-${var.environment}" # computed naming standard convention for all resources

  full_service_name = "${local.resource_prefix}-${var.app_name}" # abc-prod-ssm-proxy

  tags_app_module = merge(
    var.tags,         # Tags coming from calling TF
    local.tags_module # Tags locally added
  )

  tags_module = {
  }
}