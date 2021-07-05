module "lambda_function" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "~> 2.0"

  function_name = var.name
  description   = "Lambda function to create presigned url for uploading object to s3 bucket"
  handler       = "index.handler"
  runtime       = "nodejs12.x"
  publish = true

  source_path = "${path.module}/pre-signed-upload-url"

  environment_variables = {
    S3_BUCKET = var.s3_bucket
  }

  allowed_triggers = {
    AllowExecutionFromAPIGateway = {
      service    = "apigateway"
      source_arn = "${var.api_gateway_execution_arn}/*/*"
    }
  }

  cloudwatch_logs_tags = {
    Stack = "Unisorter"
  }

  tags = {
    Stack = "Unisorter"
  }

  attach_policy_statements = true
  policy_statements = {
    s3_put = {
      effect    = "Allow",
      actions   = ["s3:HeadObject", "s3:PutObject"],
      resources = ["arn:aws:s3:::${var.s3_bucket}/*"]
    }
  }
}