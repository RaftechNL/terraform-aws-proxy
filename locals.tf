locals {
  resource_prefix = "${var.environment}-${var.project}"

  full_service_name = var.full_service_name != "" ? var.full_service_name : "${local.resource_prefix}-${var.app_name}"

  tags_app_module = merge(
    var.tags,         # Tags coming from calling TF
    local.tags_module # Tags locally added
  )

  tags_module = {
  }
}