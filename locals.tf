locals {
  # -----------------------------------------------------------------------------
  # Assemble variables into a list of tags to be assigned to Azure resources.
  # -----------------------------------------------------------------------------
  tags = {
    product           = var.product
    cost_center       = var.cost_center
    environment       = var.environment
    region            = var.region
    owner             = var.owner
    technical_contact = var.technical_contact
    support_group     = var.support_group
    approval_group    = var.approval_group
    platform          = "ace"
  }
}
