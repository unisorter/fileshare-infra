module "lambda_function" {
  source = "terraform-aws-modules/lambda/aws"

  function_name = "s3-pre-sign-upload-url"
  description   = "Lambda function to create presign url for uploading object to s3 bucket"
  handler       = "index.lambda_handler"
  runtime       = "python3.8"

  source_path = "${path.module}/lambda-function.py"

    environment_variables = {
      S3_BUCKET = var.S3_BUCKET
  }

  tags = {
    Name = "s3-pre-sign-upload-url"
  }
}
