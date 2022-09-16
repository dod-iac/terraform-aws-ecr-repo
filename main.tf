/**
 * ## Usage
 *
 * Creates an AWS ECR repository.
 *
 * ```hcl
 * module "ecr_repo" {
 *   source = "dod-iac/ecr-repo/aws"
 *
 *   name  = format("app-%s-%s", var.application, var.environment)
 *
 *   tags = {
 *     Application = var.application
 *     Automation  = "Terraform"
 *   }
 * }
 * ```
 *
 * Creates an AWS ECR repository with container images encrypted using a customer-managed KMS key.
 *
 * ```hcl
 * module "ecr_kms_key" {
 *   source = "dod-iac/ecr-kms-key/aws"
 *
 *   name = format("alias/app-%s-ecr", var.application, var.environment)
 *   tags = {
 *     Application = var.application
 *     Automation  = "Terraform"
 *   }
 * }
 *
 * module "ecr_repo" {
 *   source = "dod-iac/ecr-repo/aws"
 *
 *   encryption_type = "KMS"
 *   kms_key_arn = module.ecr_kms_key.aws_kms_key_arn
 *   name  = format("app-%s", var.application)
 *
 *   tags = {
 *     Application = var.application
 *     Automation  = "Terraform"
 *   }
 * }
 * ```
 *
 * Use the optional `lifecycle_policy` variable to set the lifecycle policy for the repo.
 *
 * Use the optional `repository_policy` variable to set the repository policy for the repo.
 *
 * ## Terraform Version
 *
 * Terraform 0.13. Pin module version to ~> 1.0.0 . Submit pull-requests to main branch.
 *
 * Terraform 0.11 and 0.12 are not supported.
 *
 * ## License
 *
 * This project constitutes a work of the United States Government and is not subject to domestic copyright protection under 17 USC § 105.  However, because the project utilizes code licensed from contributors and other third parties, it therefore is licensed under the MIT License.  See LICENSE file for more information.
 */

data "aws_caller_identity" "current" {}

resource "aws_ecr_repository" "main" {
  name                 = var.name
  image_tag_mutability = var.immutable ? "IMMUTABLE" : "MUTABLE"
  tags                 = var.tags

  encryption_configuration {
    encryption_type = var.encryption_type
    kms_key         = length(var.kms_key_arn) > 0 ? var.kms_key_arn : null
  }

  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }
}

resource "aws_ecr_lifecycle_policy" "main" {
  count = length(var.lifecycle_policy) > 0 ? 1 : 0

  repository = aws_ecr_repository.main.name
  policy     = var.lifecycle_policy
}

resource "aws_ecr_repository_policy" "main" {
  count = length(var.repository_policy) > 0 ? 1 : 0

  repository = aws_ecr_repository.main.name
  policy     = var.repository_policy
}
