variable "allow_public_access" {
  default     = false
  description = "Whether bucket can be public. A public bucket policy will be created regardless of value but will allow public access. Further, a public acl will be used if true. Bucket policy may be used to restrict by CIDRs and other values."
  type        = bool
}

variable "bucket_access_logging_bucket" {
  default     = null
  description = "Optional target for S3 access logging"
  type        = string
}

variable "bucket_access_logging_prefix" {
  default     = null
  description = "Optional target prefix for S3 access logging (only used if `bucket_access_logging_bucket != null`)"
  type        = string
}

variable "bucket_kms_key" {
  default     = null
  description = "KMS key to use (default is the AWS-managed CMK)"
  type        = string
}

variable "bucket_name" {
  default     = null
  description = "Name to apply to bucket (use `bucket_name` or `bucket_suffix`)"
  type        = string
}

variable "bucket_suffix" {
  default     = "yumrepo"
  description = "Suffix to apply to the bucket (use `bucket_name` or `bucket_suffix`). When using `bucket_suffix`, the bucket name will be `[account_id]-[region]-[bucket_suffix]."
  type        = string
}

variable "bucket_versioning_enabled" {
  default     = true
  description = "Enable bucket versioning?"
  type        = string
}

variable "lifecycle_rules" {
  default     = []
  description = "lifecycle rules to apply to the bucket"
  type = list(object(
    {
      id                            = string
      enabled                       = bool
      prefix                        = string
      expiration                    = number
      noncurrent_version_expiration = number
  }))
}

variable "tags" {
  default     = {}
  description = "Tags to add to supported resources"
  type        = map(string)
}
