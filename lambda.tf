#
#resource "aws_lambda_permission" "this" {
#  action        = "lambda:InvokeFunction"
#  #function_name =
#  principal     = "s3.amazonaws.com"
#  source_arn    = aws_s3_bucket.this.arn
#}
#
#resource "aws_s3_bucket_notification" "this" {
#  bucket = aws_s3_bucket.this.name
#
#  lambda_function {
#    lambda_function_arn = "${module.auto_build_yum_repo.function_arn}"
#filter_prefix = var.repo_dir
#    filter_suffix = ".rpm"
#
#    events = [
#      "s3:ObjectCreated:*",
#      "s3:ObjectRemoved:*",
#    ]
#  }
#}
