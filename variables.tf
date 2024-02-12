variable "rg_backend_prod" {
  description = "Tag Value must match Business Service in Service Now Service Now - Approval Group "
  type        = string
  default     = "demoiac"
}

variable "storage_account_name_backend_prod" {
  description = "Tag Value must match Business Service in Service Now Service Now - Approval Group "
  type        = string
  default     = "iacstatesdemo"
}

variable "container_name_backend_prod" {
  description = "Tag Value must match Business Service in Service Now Service Now - Approval Group "
  type        = string
  default     = "tfstatefile"
}

variable "key_backend_prod" {
  description = "Tag Value must match Business Service in Service Now Service Now - Approval Group "
  type        = string
  default     = "demoiac"
}

# -----------------------------------------------------------------------------
# Variables
# -----------------------------------------------------------------------------

variable "location" {
  description = "Azure location"
  default     = "East US"
  type        = string
}

variable "az_tenant" {
  description = "Azure Tenant"
  type        = string
  sensitive   = true
}
# -----------------------------------------------------------------------------
# Variables ADLS
# -----------------------------------------------------------------------------
variable "adls_resource_group_name" {
  description = "Resource Group Name"
  default     = "rg-adls-noprod-eastus-001"
  type        = string
}

variable "adls_deploy_flag" {
  description = "Flag to control deployment."
  type        = bool
  default     = true
}

variable "st_adls_name" {
  description = "Resource Group Name"
  default     = "stadlsnoprodeastus001"
  type        = string
}

variable "adls_name" {
  description = "Resource Group Name"
  default     = "adlsnoprodeastus001"
  type        = string
}
# -----------------------------------------------------------------------------
# Variables ADF
# -----------------------------------------------------------------------------

variable "adf_resource_group_name" {
  description = "Resource Group Name"
  default     = "rg-adf-noprod-eastus-001"
  type        = string
}

variable "adf_name" {
  description = "Resource Group Name"
  default     = "adf-noprod-eastus-001"
  type        = string
}

variable "kv_adf_name" {
  description = "Resource Group Name"
  default     = "kv-adf-noprod-eastus-001"
  type        = string
}
variable "adf_deploy_flag" {
  description = "Flag to control deployment."
  type        = bool
  default     = false
}


# -----------------------------------------------------------------------------
# Tag Variables
# -----------------------------------------------------------------------------
# -----------------------------------------------------------------------------
# General Tag Variables
# -----------------------------------------------------------------------------
variable "product" {
  description = "The name of ACE product. A required Azure resource tag."
  type        = string
  default     = "Digital"

}
variable "owner" {
  description = "The name of the owner or team.  A required Azure resource tag."
  type        = string
  default     = "John Doe"
}

variable "technical_contact" {
  description = "The email address of the technical contact.  A required Azure resource tag."
  type        = string
  default     = "Ace support"
}

variable "cost_center" {
  description = "The cost center. A required Azure resource tag."
  type        = string
  default     = "AP810J"
}

variable "environment" {
  description = "The environment the resources reside in.  A required Azure resource tag."
  type        = string
  default     = "Prod"
}

variable "region" {
  description = "The region to create resources in.  A required Azure resource tag."
  type        = string
  default     = "East US"
}

variable "support_group" {
  description = "Tag Value must match Support Group in Service Now Service Now - Support Group"
  type        = string
  default     = "East Team"
}

variable "approval_group" {
  description = "Tag Value must match Business Service in Service Now Service Now - Approval Group "
  type        = string
  default     = "Dev Team"
}
