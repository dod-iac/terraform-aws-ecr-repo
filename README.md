<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Usage

Creates an AWS ECR repository.

```hcl
module "ecr_repo" {
  source = "dod-iac/ecr-repo/aws"

  name  = format("app-%s-%s", var.application, var.environment)

  tags = {
    Application = var.application
    Automation  = "Terraform"
  }
}
```

Creates an AWS ECR repository with container images encrypted using a customer-managed KMS key.

```hcl
module "ecr_kms_key" {
  source = "dod-iac/ecr-kms-key/aws"

  name = format("alias/app-%s-ecr", var.application, var.environment)
  tags = {
    Application = var.application
    Automation  = "Terraform"
  }
}

module "ecr_repo" {
  source = "dod-iac/ecr-repo/aws"

  encryption_type = "KMS"
  kms_key_arn = module.ecr_kms_key.aws_kms_key_arn
  name  = format("app-%s", var.application)

  tags = {
    Application = var.application
    Automation  = "Terraform"
  }
}
```

Use the optional `lifecycle_policy` variable to set the lifecycle policy for the repo.

Use the optional `repository_policy` variable to set the repository policy for the repo.

## Terraform Version

Terraform 0.13. Pin module version to ~> 1.0.0 . Submit pull-requests to main branch.

Terraform 0.11 and 0.12 are not supported.

## License

This project constitutes a work of the United States Government and is not subject to domestic copyright protection under 17 USC § 105.  However, because the project utilizes code licensed from contributors and other third parties, it therefore is licensed under the MIT License.  See LICENSE file for more information.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.0, < 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.0, < 5.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ecr_lifecycle_policy.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_lifecycle_policy) | resource |
| [aws_ecr_repository.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository) | resource |
| [aws_ecr_repository_policy.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository_policy) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_encryption_type"></a> [encryption\_type](#input\_encryption\_type) | The encryption type to use for the repository. Valid values are AES256 or KMS. | `string` | `"AES256"` | no |
| <a name="input_immutable"></a> [immutable](#input\_immutable) | If true, image tags are immutable. | `bool` | `false` | no |
| <a name="input_kms_key_arn"></a> [kms\_key\_arn](#input\_kms\_key\_arn) | The ARN of the KMS key to used to encrypt the container images. | `string` | `""` | no |
| <a name="input_lifecycle_policy"></a> [lifecycle\_policy](#input\_lifecycle\_policy) | Optional lifecycle policy for the ECR repository. | `string` | `""` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the repository. | `string` | n/a | yes |
| <a name="input_repository_policy"></a> [repository\_policy](#input\_repository\_policy) | Optional repository policy for the ECR repository. | `string` | `""` | no |
| <a name="input_scan_on_push"></a> [scan\_on\_push](#input\_scan\_on\_push) | Indicates whether images are scanned after being pushed to the repository (true) or not scanned (false). | `bool` | `true` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the ECR repo. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The Amazon Resource Name (ARN) of the AWS ECR repo. |
| <a name="output_repository_url"></a> [repository\_url](#output\_repository\_url) | The URL of the repository (in the form aws\_account\_id.dkr.ecr.region.amazonaws.com/repositoryName). |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
