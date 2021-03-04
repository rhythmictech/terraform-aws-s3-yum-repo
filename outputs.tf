output "yum_repo_bucket_arn" {
  description = "Repo Bucket ARN"
  value       = aws_s3_bucket.this.arn
}

output "yum_repo_bucket_domain_name" {
  description = "Repo Bucket Domain Name"
  value       = aws_s3_bucket.this.website_domain
}

output "yum_repo_bucket_hosted_zone_id" {
  description = "Repo Bucket Hosted Zone ID"
  value       = aws_s3_bucket.this.hosted_zone_id
}

output "yum_repo_bucket_name" {
  description = "Repo Bucket Name"
  value       = aws_s3_bucket.this.bucket
}
