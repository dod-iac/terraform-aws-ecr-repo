output "arn" {
  description = "The Amazon Resource Name (ARN) of the AWS ECR repo."
  value       = aws_ecr_repository.main.arn
}

output "repository_url" {
  description = "The URL of the repository (in the form aws_account_id.dkr.ecr.region.amazonaws.com/repositoryName)."
  value       = aws_ecr_repository.main.repository_url
}
