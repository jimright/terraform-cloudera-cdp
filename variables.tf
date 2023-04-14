# ------- Global settings -------
variable "aws_profile" {
  type        = string
  description = "Profile for AWS cloud credentials"

  # Profile is default unless explicitly specified
  default = "default"
}

variable "infra_type" {
  type        = string
  description = "Cloud Provider to deploy CDP."

  default = "aws"

  validation {
    condition     = contains(["aws"], var.infra_type)
    error_message = "Valid values for var: infra_type are (aws)."
  }
}

variable "aws_region" {
  type        = string
  description = "Region which Cloud resources will be created"

  default = null
}

variable "env_tags" {
  type        = map(any)
  description = "Tags applied to provised resources"

  default = null
}

variable "env_prefix" {
  type        = string
  description = "Shorthand name for the environment. Used in resource descriptions"
}

variable "aws_key_pair" {
  type = string

  description = "Name of the Public SSH key for the CDP environment"
}

# ------- CDP Environment Deployment -------
variable "cdp_profile" {
  type        = string
  description = "Profile for CDP credentials"

  # Profile is default unless explicitly specified
  default = "default"
}

variable "cdp_region" {
  type        = string
  description = "CDP Control Plane Region"

  # Region is us-west-1 unless explicitly specified
  default = "us-west-1"
}

variable "deployment_template" {
  type = string

  description = "Deployment Pattern to use for Cloud resources and CDP"

  validation {
    condition     = contains(["public", "semi-private", "fully-private"], var.deployment_template)
    error_message = "Valid values for var: deployment_template are (public, semi-private, fully-private)."
  }
}
variable "deploy_cdp" {
  type = bool

  description = "Deploy the CDP environment as part of Terraform"

  default = true
}

variable "lookup_cdp_account_ids" {
  type = bool

  description = "Auto lookup CDP Account and External ID using CDP CLI commands"

  default = true
}

variable "enable_raz" {
  type = bool

  description = "Flag to enable Ranger Authorization Service (RAZ)"

  default = true
}

variable "multiaz" {
  type = bool

  description = "Flag to specify that the FreeIPA instances will be deployed across multi-availability zones"

  default = false
}

variable "freeipa_instances" {
  type = number

  description = "The number of FreeIPA instances to create in the environment"

  default = 2
}

variable "workload_analytics" {
  type = bool

  description = "Flag to specify if workload analytics should be enabled for the CDP environment"

  default = true
}

variable "datalake_scale" {
  type = string

  description = "The scale of the datalake. Valid values are LIGHT_DUTY, MEDIUM_DUTY_HA."

  # NOTE: Unable to have validation when we want a default behaviour depending on deployment_template
  # validation {
  #   condition     = contains(["LIGHT_DUTY", "MEDIUM_DUTY_HA"], var.datalake_scale)
  #   error_message = "Valid values for var: datalake_scale are (LIGHT_DUTY, MEDIUM_DUTY_HA)."
  # }

  default = null
}
# ------- Network Resources -------
variable "create_vpc" {
  type = bool

  description = "Flag to specify if the VPC should be created"

  default = true
}

variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR Block"

  default = "10.10.0.0/16"
}

variable "cdp_vpc_id" {
  type        = string
  description = "VPC ID for CDP environment. Required if create_vpc is false."

  default = null
}

variable "cdp_public_subnet_ids" {
  type        = list(any)
  description = "List of public subnet ids. Required if create_vpc is false."

  default = null
}

variable "cdp_private_subnet_ids" {
  type        = list(any)
  description = "List of private subnet ids. Required if create_vpc is false."

  default = null
}

# Security Groups
variable "security_group_default_name" {
  type = string

  description = "Default Security Group for CDP environment"

  default = null
}

variable "security_group_knox_name" {
  type = string

  description = "Knox Security Group for CDP environment"

  default = null
}

variable "cdp_control_plane_cidrs" {
  type = list(string)

  description = "CIDR for access to CDP Control Plane"

  default = ["52.36.110.208/32", "52.40.165.49/32", "35.166.86.177/32"]
}

variable "ingress_extra_cidrs_and_ports" {
  type = object({
    cidrs = list(string)
    ports = list(number)
  })
  description = "List of extra CIDR blocks and ports to include in Security Group Ingress rules"

  default = {
    cidrs = [],
    ports = []
  }
}

variable "cdp_default_sg_egress_cidrs" {
  type = list(string)

  description = "List of egress CIDR blocks for CDP Default Security Group Egress rule"

  default = ["0.0.0.0/0"]
}

variable "cdp_knox_sg_egress_cidrs" {
  type = list(string)

  description = "List of egress CIDR blocks for CDP Knox Security Group Egress rule"

  default = ["0.0.0.0/0"]
}

# ------- Storage Resources -------
variable "random_id_for_bucket" {
  type = bool

  description = "Create a random suffix for the bucket names"

  default = true

}

variable "data_storage" {
  type = object({
    data_storage_bucket  = string
    data_storage_objects = list(string)
  })

  description = "Storage locations for CDP environment"

  default = null
}

variable "log_storage" {
  type = object({
    log_storage_bucket  = string
    log_storage_objects = list(string)
  })

  description = "Optional log locations for CDP environment. If not provided follow the data_storage variable"

  default = null
}

# ------- Policies -------
# Cross Account Policy (name and document)
variable "xaccount_policy_name" {
  type        = string
  description = "Cross Account Policy name"

  default = null
}

variable "xaccount_account_policy_doc" {
  type        = string
  description = "Location of cross acount policy document"

  default = null
}

# CDP IDBroker Assume Role policy
variable "idbroker_policy_name" {
  type        = string
  description = "IDBroker Policy name"

  default = null
}

# CDP Data Access Policies - Log
variable "log_data_access_policy_name" {
  type        = string
  description = "Log Data Access Policy Name"

  default = null
}

variable "log_data_access_policy_doc" {
  type        = string
  description = "Location or Contents of Log Data Access Policy"

  default = null
}

# CDP Data Access Policies - ranger_audit_s3
variable "ranger_audit_s3_policy_name" {
  type        = string
  description = "Ranger S3 Audit Data Access Policy Name"

  default = null
}

variable "ranger_audit_s3_policy_doc" {
  type        = string
  description = "Location or Contents of Ranger S3 Audit Data Access Policy"

  default = null
}

# CDP Data Access Policies - datalake_admin_s3 
variable "datalake_admin_s3_policy_name" {
  type        = string
  description = "Datalake Admin S3 Data Access Policy Name"

  default = null
}

variable "datalake_admin_s3_policy_doc" {
  type        = string
  description = "Location or Contents of Datalake Admin S3 Data Access Policy"

  default = null
}

# CDP Data Access Policies - bucket_access
variable "bucket_access_policy_name" {
  type        = string
  description = "Bucket Access Data Access Policy Name"

  default = null
}

variable "bucket_access_policy_doc" {
  type        = string
  description = "Bucket Access Data Access Policy"

  default = null
}

# ------- Roles -------
# Cross Account Role (name and id)
variable "xaccount_role_name" {
  type        = string
  description = "Cross account Assume role Name"

  default = null
}

variable "xaccount_account_id" {
  type        = string
  description = "Account ID of the cross account"

  default = null
}

variable "xaccount_external_id" {
  type        = string
  description = "External ID of the cross account"

  default = null
}

# IDBroker service role
variable "idbroker_role_name" {
  type        = string
  description = "IDBroker service role Name"

  default = null
}

# Log service role
variable "log_role_name" {
  type        = string
  description = "Log service role Name"

  default = null
}

# CDP Datalake Admin role
variable "datalake_admin_role_name" {
  type        = string
  description = "Datalake Admin role Name"

  default = null
}

# CDP Ranger Audit role
variable "ranger_audit_role_name" {
  type        = string
  description = "Ranger Audit role Name"

  default = null
}
