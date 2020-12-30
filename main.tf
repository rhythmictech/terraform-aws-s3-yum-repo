data "aws_caller_identity" "current" {
}

data "aws_region" "current" {
}

locals {
  account_id = data.aws_caller_identity.current.account_id
  bucket_acl = var.allow_public_access ? "public" : "private"
  region     = data.aws_region.current.name

  bucket_name = coalesce(
    var.bucket_name,
    "${local.account_id}-${local.region}-${var.bucket_suffix}"
  )

  logging = var.bucket_access_logging_bucket == null ? [] : [{
    bucket = var.bucket_access_logging_bucket
    prefix = var.bucket_access_logging_prefix
  }]
}

#tfsec:ignore:AWS002
resource "aws_s3_bucket" "this" {
  bucket = local.bucket_name
  acl    = local.bucket_acl
  tags   = var.tags

  dynamic "lifecycle_rule" {
    iterator = rule
    for_each = var.lifecycle_rules

    content {
      id      = rule.value.id
      enabled = rule.value.enabled
      prefix  = lookup(rule.value, "prefix", null)

      expiration {
        days = lookup(rule.value, "expiration", 2147483647)
      }

      noncurrent_version_expiration {
        days = lookup(rule.value, "noncurrent_version_expiration", 2147483647)
      }
    }
  }

  dynamic "logging" {
    iterator = log
    for_each = local.logging

    content {
      target_bucket = log.value.bucket
      target_prefix = lookup(log.value, "prefix", null)
    }
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = var.bucket_kms_key
        sse_algorithm     = "aws:kms"
      }
    }
  }

  versioning {
    enabled = var.bucket_versioning_enabled
  }

  lifecycle {
    ignore_changes = [versioning[0].mfa_delete]
  }
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket                  = aws_s3_bucket.this.id
  block_public_acls       = ! var.allow_public_access
  block_public_policy     = ! var.allow_public_access
  ignore_public_acls      = ! var.allow_public_access
  restrict_public_buckets = ! var.allow_public_access
}
