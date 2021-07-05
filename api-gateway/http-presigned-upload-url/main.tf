module "api_gateway" {
  source = "terraform-aws-modules/apigateway-v2/aws"

  name                             = "${var.name}-http-api"
  description                      = "API Gatway_2 API to generate presigned URL for upload object to S3 bucket"
  protocol_type                    = "HTTP"
  create_api_domain_name           = false
  create_default_stage_api_mapping = false

  cors_configuration = {
    allow_headers = ["content-type", "x-amz-date", "authorization", "x-api-key", "x-amz-security-token", "x-amz-user-agent"]
    allow_methods = ["*"]
    allow_origins = ["*"]
  }

  default_stage_access_log_destination_arn = aws_cloudwatch_log_group.logs.arn
  default_stage_access_log_format          = "$context.identity.sourceIp - - [$context.requestTime] \"$context.httpMethod $context.routeKey $context.protocol\" $context.status $context.responseLength $context.requestId $context.integrationErrorMessage"

  default_route_settings = {
    detailed_metrics_enabled = false
    throttling_burst_limit   = 100
    throttling_rate_limit    = 100
  }

  integrations = {
    "GET /" = {
      lambda_arn             = module.lambda_function.lambda_function_arn
      payload_format_version = "2.0"
      timeout_milliseconds   = 3000
      #   authorization_type     = "JWT"
      #   authorizer_id          = aws_apigatewayv2_authorizer.some_authorizer.id
    }

  }

  tags = {
    Stack = "Unisorter"
  }
}

resource "aws_cloudwatch_log_group" "logs" {
  name = "/aws/api-gaeway/${var.name}"

  tags = {
    Stack = "Unisorter"
  }
}

module "lambda_function" {

  source                    = "./lambda"
  name                      = var.name
  s3_bucket                 = var.s3_bucket
  api_gateway_execution_arn = module.api_gateway.apigatewayv2_api_execution_arn

}

#############################
# AWS API Gateway Authorizer
#############################

# resource "aws_apigatewayv2_authorizer" "some_authorizer" {
#   api_id           = module.api_gateway.apigatewayv2_api_id
#   authorizer_type  = "JWT"
#   identity_sources = ["$request.header.Authorization"]
#   name             = random_pet.this.id

#   jwt_configuration {
#     audience = ["example"]
#     issuer   = "https://${aws_cognito_user_pool.this.endpoint}"
#   }
# }

########################
# AWS Cognito User Pool
########################

# resource "aws_cognito_user_pool" "this" {
#   name = "user-pool-${random_pet.this.id}"
# }


###############################################
# S3 bucket and TLS certificate for truststore
###############################################

# resource "aws_s3_bucket" "truststore" {
#   bucket = "${random_pet.this.id}-truststore"
#   acl    = "private"
# }

# resource "aws_s3_bucket_object" "truststore" {
#   bucket                 = aws_s3_bucket.truststore.bucket
#   key                    = "truststore.pem"
#   server_side_encryption = "AES256"
#   content                = tls_self_signed_cert.example.cert_pem
# }

# resource "tls_private_key" "private_key" {
#   algorithm = "RSA"
# }

# resource "tls_self_signed_cert" "example" {
#   key_algorithm     = tls_private_key.private_key.algorithm
#   is_ca_certificate = true
#   private_key_pem   = tls_private_key.private_key.private_key_pem

#   subject {
#     common_name  = "example.com"
#     organization = "ACME Examples, Inc"
#   }

#   validity_period_hours = 12

#   allowed_uses = [
#     "cert_signing",
#     "server_auth",
#   ]
# }
