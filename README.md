# terraform-aws-s3-yum-repo

Creates and manages a yum repo in an S3 bucket. Automatically runs createrepo to update repo metadata every time objects are added or removed. 

This module is based loosely off of a [Claranet module](https://github.com/claranet/terraform-aws-s3-yum-repo), but redone to eliminate the CodeBuild dependency and work solely with Lambda. Also to support modern TF versions. Many thanks to them for the idea, though.

[![tflint](https://github.com/rhythmictech/terraform-aws-s3-yum-repo/workflows/tflint/badge.svg?branch=master&event=push)](https://github.com/rhythmictech/terraform-aws-s3-yum-repo/actions?query=workflow%3Atflint+event%3Apush+branch%3Amaster)
[![tfsec](https://github.com/rhythmictech/terraform-aws-s3-yum-repo/workflows/tfsec/badge.svg?branch=master&event=push)](https://github.com/rhythmictech/terraform-aws-s3-yum-repo/actions?query=workflow%3Atfsec+event%3Apush+branch%3Amaster)
[![yamllint](https://github.com/rhythmictech/terraform-aws-s3-yum-repo/workflows/yamllint/badge.svg?branch=master&event=push)](https://github.com/rhythmictech/terraform-aws-s3-yum-repo/actions?query=workflow%3Ayamllint+event%3Apush+branch%3Amaster)
[![misspell](https://github.com/rhythmictech/terraform-aws-s3-yum-repo/workflows/misspell/badge.svg?branch=master&event=push)](https://github.com/rhythmictech/terraform-aws-s3-yum-repo/actions?query=workflow%3Amisspell+event%3Apush+branch%3Amaster)
[![pre-commit-check](https://github.com/rhythmictech/terraform-aws-s3-yum-repo/workflows/pre-commit-check/badge.svg?branch=master&event=push)](https://github.com/rhythmictech/terraform-aws-s3-yum-repo/actions?query=workflow%3Apre-commit-check+event%3Apush+branch%3Amaster)
<a href="https://twitter.com/intent/follow?screen_name=RhythmicTech"><img src="https://img.shields.io/twitter/follow/RhythmicTech?style=social&logo=twitter" alt="follow on Twitter"></a>

## Example

```hcl
module "example" {
  source = "rhythmictech/terraform-aws-s3-yum-repo
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12.19 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 2.65 |
| <a name="requirement_template"></a> [template](#requirement\_template) | >= 2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 2.65 |
| <a name="provider_template"></a> [template](#provider\_template) | >= 2.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_s3_bucket.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_object.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_object) | resource |
| [aws_s3_bucket_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_public_access_block.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [template_file.this](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allow_public_access"></a> [allow\_public\_access](#input\_allow\_public\_access) | Whether bucket can be public. A public bucket policy will be created regardless of value but will allow public access. Further, a public acl will be used if true. Bucket policy may be used to restrict by CIDRs and other values. | `bool` | `false` | no |
| <a name="input_bucket_access_logging_bucket"></a> [bucket\_access\_logging\_bucket](#input\_bucket\_access\_logging\_bucket) | Optional target for S3 access logging | `string` | `null` | no |
| <a name="input_bucket_access_logging_prefix"></a> [bucket\_access\_logging\_prefix](#input\_bucket\_access\_logging\_prefix) | Optional target prefix for S3 access logging (only used if `bucket_access_logging_bucket != null`) | `string` | `null` | no |
| <a name="input_bucket_kms_key"></a> [bucket\_kms\_key](#input\_bucket\_kms\_key) | KMS key to use (default is the AWS-managed CMK). var.sse\_enabled must be true | `string` | `null` | no |
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | Name to apply to bucket (use `bucket_name` or `bucket_suffix`) | `string` | `null` | no |
| <a name="input_bucket_suffix"></a> [bucket\_suffix](#input\_bucket\_suffix) | Suffix to apply to the bucket (use `bucket_name` or `bucket_suffix`). When using `bucket_suffix`, the bucket name will be `[account_id]-[region]-[bucket_suffix].` | `string` | `"yumrepo"` | no |
| <a name="input_bucket_versioning_enabled"></a> [bucket\_versioning\_enabled](#input\_bucket\_versioning\_enabled) | Enable bucket versioning? | `string` | `true` | no |
| <a name="input_lifecycle_rules"></a> [lifecycle\_rules](#input\_lifecycle\_rules) | lifecycle rules to apply to the bucket | <pre>list(object(<br>    {<br>      id                            = string<br>      enabled                       = bool<br>      prefix                        = string<br>      expiration                    = number<br>      noncurrent_version_expiration = number<br>  }))</pre> | `[]` | no |
| <a name="input_sse_enabled"></a> [sse\_enabled](#input\_sse\_enabled) | Boolean to enable SSE. must be true for bucket\_kms\_key to have an a effect | `bool` | `true` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to add to supported resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_yum_repo_bucket_arn"></a> [yum\_repo\_bucket\_arn](#output\_yum\_repo\_bucket\_arn) | Repo Bucket ARN |
| <a name="output_yum_repo_bucket_domain_name"></a> [yum\_repo\_bucket\_domain\_name](#output\_yum\_repo\_bucket\_domain\_name) | Repo Bucket Domain Name |
| <a name="output_yum_repo_bucket_hosted_zone_id"></a> [yum\_repo\_bucket\_hosted\_zone\_id](#output\_yum\_repo\_bucket\_hosted\_zone\_id) | Repo Bucket Hosted Zone ID |
| <a name="output_yum_repo_bucket_name"></a> [yum\_repo\_bucket\_name](#output\_yum\_repo\_bucket\_name) | Repo Bucket Name |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
