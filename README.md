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
| terraform | >= 0.12.19 |
| aws | >= 2.65 |
| template | >= 2.0 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 2.65 |
| template | >= 2.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| allow\_public\_access | Whether bucket can be public. A public bucket policy will be created regardless of value but will allow public access. Further, a public acl will be used if true. Bucket policy may be used to restrict by CIDRs and other values. | `bool` | `false` | no |
| bucket\_access\_logging\_bucket | Optional target for S3 access logging | `string` | `null` | no |
| bucket\_access\_logging\_prefix | Optional target prefix for S3 access logging (only used if `bucket_access_logging_bucket != null`) | `string` | `null` | no |
| bucket\_kms\_key | KMS key to use (default is the AWS-managed CMK) | `string` | `null` | no |
| bucket\_name | Name to apply to bucket (use `bucket_name` or `bucket_suffix`) | `string` | `null` | no |
| bucket\_suffix | Suffix to apply to the bucket (use `bucket_name` or `bucket_suffix`). When using `bucket_suffix`, the bucket name will be `[account_id]-[region]-[bucket_suffix].` | `string` | `"yumrepo"` | no |
| bucket\_versioning\_enabled | Enable bucket versioning? | `string` | `true` | no |
| lifecycle\_rules | lifecycle rules to apply to the bucket | <pre>list(object(<br>    {<br>      id                            = string<br>      enabled                       = bool<br>      prefix                        = string<br>      expiration                    = number<br>      noncurrent_version_expiration = number<br>  }))</pre> | `[]` | no |
| tags | Tags to add to supported resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| yum\_repo\_bucket\_arn | Repo Bucket ARN |
| yum\_repo\_bucket\_domain\_name | Repo Bucket Domain Name |
| yum\_repo\_bucket\_name | Repo Bucket Name |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
