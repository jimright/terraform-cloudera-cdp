<!-- BEGIN_TF_DOCS -->
# Terraform Module for CDP Prerequisites

This module contains resource files and example variable definition files for creation of the pre-requisite Cloud resources on AWS and optional deployment of Cloudera Data Platform (CDP) Public Cloud.

## Usage

The [examples](./examples) directory has example AWS Cloud Service Provider deployments for different scenarios:

* `ex01-minimal-inputs` uses the minimum set of inputs for the module.

* `ex02-existing-vpc` creates a VPC and subnets outside of the module and passes this as an additional input. CDP deployment then uses these network assets.

* `ex03-create-keypair` creates the AWS EC2 Keypair in the module caller and passes this as an additional input.

* TODO: `ex04-all_inputs_specified` contains an example with all input parameters for the module.

In each directory an example `terraform.tfvars.sample` values file is included to show input variable values.

## Deployment

### Create infrastructure

1. Clone this repository using the following commands:

```bash
git clone https://github.com/aws-ia/terraform-cloudera-cdp.git  
cd terraform-cloudera-cdp
```

2. Choose one of the deployment types in the [examples](./examples) directory and change to this directory.

```bash
cd examples/ex<deployment_type>/
```

3. Create a `terraform.tfvars` file with variable definitions to run the module. Reference the `terraform.tfvars.sample` file in each example folder to create this file.

4. Run the Terraform module for the chosen deployment type:

```bash
terraform init
terraform apply
```

Once the deployment completes, you can create CDP Data Hubs and Data Services from the CDP Management Console (https://cdp.cloudera.com/).

## Clean up the infrastructure

If you no longer need the infrastructure that’s provisioned by the Terraform module, run the following command to remove the deployment infrastructure and terminate all resources.

```bash
terraform destroy
```

## External dependencies

The module includes the option to discover the cross account Ids and to run the CDP deployment using external tools.

To utilize these options extra requirements are needed - Python 3, Ansible 2.12, the CDP CLI, the [jq utility](https://stedolan.github.io/jq/download/) and a number of support Python libraries and Ansible collections.

A summary of the install and configuration steps for these additional requirements is given below.
We recommend these steps be performed within an Python virtual environment.

```bash
# Install jq as per instructions at https://stedolan.github.io/jq/download/
# Example for MacOS using homebew shown below
brew install jq

# Install the Ansible core Python package
pip install ansible-core==2.12.10 jmespath==1.0.1

# Install cdpy, a Pythonic wrapper for Cloudera CDP CLI. This in turn installs the CDP CLI.
pip install git+https://github.com/cloudera-labs/cdpy@main#egg=cdpy

# Install the cloudera.cloud Ansible Collection
ansible-galaxy collection install git+https://github.com/cloudera-labs/cloudera.cloud.git

# Install the community.general Ansible Collection
ansible-galaxy collection install community.general:==5.5.0

# Configure cdp with CDP API access key ID and private key
cdp configure
```

NOTE - See the [CDP documentation for steps to Generate the API access key](https://docs.cloudera.com/cdp-public-cloud/cloud/cli/topics/mc-cli-generating-an-api-access-key.html) required in the `cdp configure` command above.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | > 1.3.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.0 |
| <a name="requirement_external"></a> [external](#requirement\_external) | 2.3.1 |
| <a name="requirement_http"></a> [http](#requirement\_http) | 3.2.1 |
| <a name="requirement_local"></a> [local](#requirement\_local) | 2.2.3 |
| <a name="requirement_null"></a> [null](#requirement\_null) | 3.2.1 |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.4.3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 4.0 |
| <a name="provider_external"></a> [external](#provider\_external) | 2.3.1 |
| <a name="provider_http"></a> [http](#provider\_http) | 3.2.1 |
| <a name="provider_local"></a> [local](#provider\_local) | 2.2.3 |
| <a name="provider_null"></a> [null](#provider\_null) | 3.2.1 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.4.3 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_aws_cdp_vpc"></a> [aws\_cdp\_vpc](#module\_aws\_cdp\_vpc) | ./modules/vpc | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_iam_instance_profile.cdp_datalake_admin_role_instance_profile](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_instance_profile.cdp_idbroker_role_instance_profile](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_instance_profile.cdp_log_role_instance_profile](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_instance_profile.cdp_ranger_audit_role_instance_profile](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_policy.cdp_bucket_data_access_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.cdp_datalake_admin_s3_data_access_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.cdp_idbroker_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.cdp_log_data_access_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.cdp_ranger_audit_s3_data_access_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.cdp_xaccount_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.cdp_datalake_admin_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.cdp_idbroker_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.cdp_log_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.cdp_ranger_audit_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.cdp_xaccount_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.cdp_datalake_admin_role_attach1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.cdp_datalake_admin_role_attach2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.cdp_idbroker_role_attach1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.cdp_idbroker_role_attach2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.cdp_log_role_attach1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.cdp_log_role_attach2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.cdp_ranger_audit_role_attach1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.cdp_ranger_audit_role_attach2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.cdp_xaccount_role_attach](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_s3_bucket.cdp_storage_locations](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_object.cdp_data_storage_object](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object) | resource |
| [aws_s3_object.cdp_log_storage_object](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object) | resource |
| [aws_security_group.cdp_default_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.cdp_knox_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.cdp_default_sg_egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.cdp_default_sg_ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.cdp_default_sg_ingress_self](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.cdp_knox_sg_egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.cdp_knox_sg_ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.cdp_knox_sg_ingress_self](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [local_file.cdp_deployment_template](https://registry.terraform.io/providers/hashicorp/local/2.2.3/docs/resources/file) | resource |
| [null_resource.cdp_deployment](https://registry.terraform.io/providers/hashicorp/null/3.2.1/docs/resources/resource) | resource |
| [random_id.bucket_suffix](https://registry.terraform.io/providers/hashicorp/random/3.4.3/docs/resources/id) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.cdp_datalake_admin_role_policy_doc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.cdp_idbroker_policy_doc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.cdp_idbroker_role_policy_doc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.cdp_log_role_policy_doc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.cdp_ranger_audit_role_policy_doc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.cdp_xaccount_role_policy_doc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [external_external.cdpcli](https://registry.terraform.io/providers/hashicorp/external/2.3.1/docs/data-sources/external) | data source |
| [http_http.bucket_access_policy_doc](https://registry.terraform.io/providers/hashicorp/http/3.2.1/docs/data-sources/http) | data source |
| [http_http.datalake_admin_s3_policy_doc](https://registry.terraform.io/providers/hashicorp/http/3.2.1/docs/data-sources/http) | data source |
| [http_http.log_data_access_policy_doc](https://registry.terraform.io/providers/hashicorp/http/3.2.1/docs/data-sources/http) | data source |
| [http_http.ranger_audit_s3_policy_doc](https://registry.terraform.io/providers/hashicorp/http/3.2.1/docs/data-sources/http) | data source |
| [http_http.xaccount_account_policy_doc](https://registry.terraform.io/providers/hashicorp/http/3.2.1/docs/data-sources/http) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_key_pair"></a> [aws\_key\_pair](#input\_aws\_key\_pair) | Name of the Public SSH key for the CDP environment | `string` | n/a | yes |
| <a name="input_deployment_template"></a> [deployment\_template](#input\_deployment\_template) | Deployment Pattern to use for Cloud resources and CDP | `string` | n/a | yes |
| <a name="input_env_prefix"></a> [env\_prefix](#input\_env\_prefix) | Shorthand name for the environment. Used in resource descriptions | `string` | n/a | yes |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | Region which Cloud resources will be created | `string` | `null` | no |
| <a name="input_bucket_access_policy_doc"></a> [bucket\_access\_policy\_doc](#input\_bucket\_access\_policy\_doc) | Bucket Access Data Access Policy | `string` | `null` | no |
| <a name="input_bucket_access_policy_name"></a> [bucket\_access\_policy\_name](#input\_bucket\_access\_policy\_name) | Bucket Access Data Access Policy Name | `string` | `null` | no |
| <a name="input_cdp_control_plane_cidrs"></a> [cdp\_control\_plane\_cidrs](#input\_cdp\_control\_plane\_cidrs) | CIDR for access to CDP Control Plane | `list(string)` | <pre>[<br>  "52.36.110.208/32",<br>  "52.40.165.49/32",<br>  "35.166.86.177/32"<br>]</pre> | no |
| <a name="input_cdp_default_sg_egress_cidrs"></a> [cdp\_default\_sg\_egress\_cidrs](#input\_cdp\_default\_sg\_egress\_cidrs) | List of egress CIDR blocks for CDP Default Security Group Egress rule | `list(string)` | <pre>[<br>  "35.80.24.128/27"<br>]</pre> | no |
| <a name="input_cdp_knox_sg_egress_cidrs"></a> [cdp\_knox\_sg\_egress\_cidrs](#input\_cdp\_knox\_sg\_egress\_cidrs) | List of egress CIDR blocks for CDP Knox Security Group Egress rule | `list(string)` | <pre>[<br>  "35.80.24.128/27"<br>]</pre> | no |
| <a name="input_cdp_private_subnet_ids"></a> [cdp\_private\_subnet\_ids](#input\_cdp\_private\_subnet\_ids) | List of private subnet ids. Required if create\_vpc is false. | `list(any)` | `null` | no |
| <a name="input_cdp_profile"></a> [cdp\_profile](#input\_cdp\_profile) | Profile for CDP credentials | `string` | `"default"` | no |
| <a name="input_cdp_public_subnet_ids"></a> [cdp\_public\_subnet\_ids](#input\_cdp\_public\_subnet\_ids) | List of public subnet ids. Required if create\_vpc is false. | `list(any)` | `null` | no |
| <a name="input_cdp_region"></a> [cdp\_region](#input\_cdp\_region) | CDP Control Plane Region | `string` | `"us-west-1"` | no |
| <a name="input_cdp_vpc_id"></a> [cdp\_vpc\_id](#input\_cdp\_vpc\_id) | VPC ID for CDP environment. Required if create\_vpc is false. | `string` | `null` | no |
| <a name="input_create_vpc"></a> [create\_vpc](#input\_create\_vpc) | Flag to specify if the VPC should be created | `bool` | `true` | no |
| <a name="input_data_storage"></a> [data\_storage](#input\_data\_storage) | Storage locations for CDP environment | <pre>object({<br>    data_storage_bucket  = string<br>    data_storage_objects = list(string)<br>  })</pre> | `null` | no |
| <a name="input_datalake_admin_role_name"></a> [datalake\_admin\_role\_name](#input\_datalake\_admin\_role\_name) | Datalake Admin role Name | `string` | `null` | no |
| <a name="input_datalake_admin_s3_policy_doc"></a> [datalake\_admin\_s3\_policy\_doc](#input\_datalake\_admin\_s3\_policy\_doc) | Location or Contents of Datalake Admin S3 Data Access Policy | `string` | `null` | no |
| <a name="input_datalake_admin_s3_policy_name"></a> [datalake\_admin\_s3\_policy\_name](#input\_datalake\_admin\_s3\_policy\_name) | Datalake Admin S3 Data Access Policy Name | `string` | `null` | no |
| <a name="input_datalake_scale"></a> [datalake\_scale](#input\_datalake\_scale) | The scale of the datalake. Valid values are LIGHT\_DUTY, MEDIUM\_DUTY\_HA. | `string` | `null` | no |
| <a name="input_deploy_cdp"></a> [deploy\_cdp](#input\_deploy\_cdp) | Deploy the CDP environment as part of Terraform | `bool` | `true` | no |
| <a name="input_enable_raz"></a> [enable\_raz](#input\_enable\_raz) | Flag to enable Ranger Authorization Service (RAZ) | `bool` | `true` | no |
| <a name="input_env_tags"></a> [env\_tags](#input\_env\_tags) | Tags applied to provised resources | `map(any)` | `null` | no |
| <a name="input_freeipa_instances"></a> [freeipa\_instances](#input\_freeipa\_instances) | The number of FreeIPA instances to create in the environment | `number` | `2` | no |
| <a name="input_idbroker_policy_name"></a> [idbroker\_policy\_name](#input\_idbroker\_policy\_name) | IDBroker Policy name | `string` | `null` | no |
| <a name="input_idbroker_role_name"></a> [idbroker\_role\_name](#input\_idbroker\_role\_name) | IDBroker service role Name | `string` | `null` | no |
| <a name="input_infra_type"></a> [infra\_type](#input\_infra\_type) | Cloud Provider to deploy CDP. | `string` | `"aws"` | no |
| <a name="input_ingress_extra_cidrs_and_ports"></a> [ingress\_extra\_cidrs\_and\_ports](#input\_ingress\_extra\_cidrs\_and\_ports) | List of extra CIDR blocks and ports to include in Security Group Ingress rules | <pre>object({<br>    cidrs = list(string)<br>    ports = list(number)<br>  })</pre> | <pre>{<br>  "cidrs": [],<br>  "ports": []<br>}</pre> | no |
| <a name="input_log_data_access_policy_doc"></a> [log\_data\_access\_policy\_doc](#input\_log\_data\_access\_policy\_doc) | Location or Contents of Log Data Access Policy | `string` | `null` | no |
| <a name="input_log_data_access_policy_name"></a> [log\_data\_access\_policy\_name](#input\_log\_data\_access\_policy\_name) | Log Data Access Policy Name | `string` | `null` | no |
| <a name="input_log_role_name"></a> [log\_role\_name](#input\_log\_role\_name) | Log service role Name | `string` | `null` | no |
| <a name="input_log_storage"></a> [log\_storage](#input\_log\_storage) | Optional log locations for CDP environment. If not provided follow the data\_storage variable | <pre>object({<br>    log_storage_bucket  = string<br>    log_storage_objects = list(string)<br>  })</pre> | `null` | no |
| <a name="input_lookup_cdp_account_ids"></a> [lookup\_cdp\_account\_ids](#input\_lookup\_cdp\_account\_ids) | Auto lookup CDP Account and External ID using CDP CLI commands | `bool` | `true` | no |
| <a name="input_multiaz"></a> [multiaz](#input\_multiaz) | Flag to specify that the FreeIPA instances will be deployed across multi-availability zones | `bool` | `false` | no |
| <a name="input_random_id_for_bucket"></a> [random\_id\_for\_bucket](#input\_random\_id\_for\_bucket) | Create a random suffix for the bucket names | `bool` | `true` | no |
| <a name="input_ranger_audit_role_name"></a> [ranger\_audit\_role\_name](#input\_ranger\_audit\_role\_name) | Ranger Audit role Name | `string` | `null` | no |
| <a name="input_ranger_audit_s3_policy_doc"></a> [ranger\_audit\_s3\_policy\_doc](#input\_ranger\_audit\_s3\_policy\_doc) | Location or Contents of Ranger S3 Audit Data Access Policy | `string` | `null` | no |
| <a name="input_ranger_audit_s3_policy_name"></a> [ranger\_audit\_s3\_policy\_name](#input\_ranger\_audit\_s3\_policy\_name) | Ranger S3 Audit Data Access Policy Name | `string` | `null` | no |
| <a name="input_security_group_default_name"></a> [security\_group\_default\_name](#input\_security\_group\_default\_name) | Default Security Group for CDP environment | `string` | `null` | no |
| <a name="input_security_group_knox_name"></a> [security\_group\_knox\_name](#input\_security\_group\_knox\_name) | Knox Security Group for CDP environment | `string` | `null` | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | VPC CIDR Block | `string` | `"10.10.0.0/16"` | no |
| <a name="input_workload_analytics"></a> [workload\_analytics](#input\_workload\_analytics) | Flag to specify if workload analytics should be enabled for the CDP environment | `bool` | `true` | no |
| <a name="input_xaccount_account_id"></a> [xaccount\_account\_id](#input\_xaccount\_account\_id) | Account ID of the cross account | `string` | `null` | no |
| <a name="input_xaccount_account_policy_doc"></a> [xaccount\_account\_policy\_doc](#input\_xaccount\_account\_policy\_doc) | Location of cross acount policy document | `string` | `null` | no |
| <a name="input_xaccount_external_id"></a> [xaccount\_external\_id](#input\_xaccount\_external\_id) | External ID of the cross account | `string` | `null` | no |
| <a name="input_xaccount_policy_name"></a> [xaccount\_policy\_name](#input\_xaccount\_policy\_name) | Cross Account Policy name | `string` | `null` | no |
| <a name="input_xaccount_role_name"></a> [xaccount\_role\_name](#input\_xaccount\_role\_name) | Cross account Assume role Name | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_datalake_admin_role_arn"></a> [aws\_datalake\_admin\_role\_arn](#output\_aws\_datalake\_admin\_role\_arn) | Datalake Admin role ARN |
| <a name="output_aws_default_route_table_id"></a> [aws\_default\_route\_table\_id](#output\_aws\_default\_route\_table\_id) | AWS default route table ID |
| <a name="output_aws_idbroker_instance_profile_arn"></a> [aws\_idbroker\_instance\_profile\_arn](#output\_aws\_idbroker\_instance\_profile\_arn) | IDBroker instance profile ARN |
| <a name="output_aws_log_instance_profile_arn"></a> [aws\_log\_instance\_profile\_arn](#output\_aws\_log\_instance\_profile\_arn) | Log instance profile ARN |
| <a name="output_aws_log_location"></a> [aws\_log\_location](#output\_aws\_log\_location) | AWS log storage location |
| <a name="output_aws_private_route_table_ids"></a> [aws\_private\_route\_table\_ids](#output\_aws\_private\_route\_table\_ids) | AWS private route table IDs |
| <a name="output_aws_private_subnet_ids"></a> [aws\_private\_subnet\_ids](#output\_aws\_private\_subnet\_ids) | AWS private subnet IDs |
| <a name="output_aws_public_route_table_ids"></a> [aws\_public\_route\_table\_ids](#output\_aws\_public\_route\_table\_ids) | AWS public route table IDs |
| <a name="output_aws_public_subnet_ids"></a> [aws\_public\_subnet\_ids](#output\_aws\_public\_subnet\_ids) | AWS public subnet IDs |
| <a name="output_aws_ranger_audit_role_arn"></a> [aws\_ranger\_audit\_role\_arn](#output\_aws\_ranger\_audit\_role\_arn) | Ranger Audit role ARN |
| <a name="output_aws_region"></a> [aws\_region](#output\_aws\_region) | Cloud provider region of the Environment |
| <a name="output_aws_security_group_default_id"></a> [aws\_security\_group\_default\_id](#output\_aws\_security\_group\_default\_id) | AWS security group id for default CDP SG |
| <a name="output_aws_security_group_knox_id"></a> [aws\_security\_group\_knox\_id](#output\_aws\_security\_group\_knox\_id) | AWS security group id for Knox CDP SG |
| <a name="output_aws_storage_location"></a> [aws\_storage\_location](#output\_aws\_storage\_location) | AWS data storage location |
| <a name="output_aws_vpc_id"></a> [aws\_vpc\_id](#output\_aws\_vpc\_id) | AWS VPC ID |
| <a name="output_aws_xaccount_role_arn"></a> [aws\_xaccount\_role\_arn](#output\_aws\_xaccount\_role\_arn) | Cross Account role ARN |
| <a name="output_cdp_datalake_name"></a> [cdp\_datalake\_name](#output\_cdp\_datalake\_name) | CDP Datalake name |
| <a name="output_cdp_enable_multiaz"></a> [cdp\_enable\_multiaz](#output\_cdp\_enable\_multiaz) | Flag to specify if multi-AZ deployment is enabled for the CDP environment |
| <a name="output_cdp_enable_raz"></a> [cdp\_enable\_raz](#output\_cdp\_enable\_raz) | Flag to enable Ranger Authorization Service (RAZ) for the CDP environment |
| <a name="output_cdp_endpoint_access_scheme"></a> [cdp\_endpoint\_access\_scheme](#output\_cdp\_endpoint\_access\_scheme) | The scheme for the workload endpoint gateway. `PUBLIC` creates an external endpoint that can be accessed over the Internet. `PRIVATE` restricts the traffic to be internal to the VPC / Vnet. Relevant in Private Networks. |
| <a name="output_cdp_env_name"></a> [cdp\_env\_name](#output\_cdp\_env\_name) | CDP environment name |
| <a name="output_cdp_freeipa_instances"></a> [cdp\_freeipa\_instances](#output\_cdp\_freeipa\_instances) | Number of instances for the FreeIPA service of the environment |
| <a name="output_cdp_iam_admin_group_name"></a> [cdp\_iam\_admin\_group\_name](#output\_cdp\_iam\_admin\_group\_name) | CDP IAM admin group name |
| <a name="output_cdp_iam_user_group_name"></a> [cdp\_iam\_user\_group\_name](#output\_cdp\_iam\_user\_group\_name) | CDP IAM user group name |
| <a name="output_cdp_profile"></a> [cdp\_profile](#output\_cdp\_profile) | Profile for CDP credentials |
| <a name="output_cdp_region"></a> [cdp\_region](#output\_cdp\_region) | CDP Control Plane region |
| <a name="output_cdp_tunnel_enabled"></a> [cdp\_tunnel\_enabled](#output\_cdp\_tunnel\_enabled) | Flag to enable SSH tunnelling for the CDP environment |
| <a name="output_cdp_workload_analytics"></a> [cdp\_workload\_analytics](#output\_cdp\_workload\_analytics) | Flag to enable Workload Analytics |
| <a name="output_cdp_xacccount_credential_name"></a> [cdp\_xacccount\_credential\_name](#output\_cdp\_xacccount\_credential\_name) | Cross Account credential name |
| <a name="output_infra_type"></a> [infra\_type](#output\_infra\_type) | Cloud Service Provider type |
| <a name="output_public_key_id"></a> [public\_key\_id](#output\_public\_key\_id) | Keypair name in Cloud Service Provider |
| <a name="output_tags"></a> [tags](#output\_tags) | Tags associated with the environment and its resources |
<!-- END_TF_DOCS -->