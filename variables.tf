variable "encryption_type" {
  type        = string
  description = "The encryption type to use for the repository. Valid values are AES256 or KMS."
  default     = "AES256"
}

variable "immutable" {
  type        = bool
  default     = false
  description = "If true, image tags are immutable."
}

variable "kms_key_arn" {
  type        = string
  description = "The ARN of the KMS key to used to encrypt the container images."
  default     = ""
}

variable "lifecycle_policy" {
  type        = string
  description = "Optional lifecycle policy for the ECR repository."
  default     = ""
}

variable "name" {
  type        = string
  description = "Name of the repository."
}

variable "repository_policy" {
  type        = string
  description = "Optional repository policy for the ECR repository."
  default     = ""
}

variable "scan_on_push" {
  type        = bool
  description = "Indicates whether images are scanned after being pushed to the repository (true) or not scanned (false)."
  default     = true
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the ECR repo."
  default     = {}
}
