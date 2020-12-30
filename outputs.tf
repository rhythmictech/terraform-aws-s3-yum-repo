output "yum_repo_bucket_arn" {
  description = "Repo Bucket ARN"
  value       = aws_s3_bucket.this.arn
}

output "yum_repo_bucket_name" {
  description = "Repo Bucket Name"
  value       = aws_s3_bucket.this.bucket
}
