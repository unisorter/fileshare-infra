# Lambda Function
output "lambda_function_arn" {
  description = "The ARN of the Lambda Function"
  value       = module.lambda_function.lambda_function_arn
}

output "lambda_function_invoke_arn" {
  description = "The Invoke ARN of the Lambda Function"
  value       = module.lambda_function.lambda_function_invoke_arn
}

output "lambda_function_name" {
  description = "The name of the Lambda Function"
  value       = module.lambda_function.lambda_function_name
}

output "lambda_function_qualified_arn" {
  description = "The ARN identifying your Lambda Function Version"
  value       = module.lambda_function.lambda_function_qualified_arn
}

output "lambda_function_version" {
  description = "Latest published version of Lambda Function"
  value       = module.lambda_function.lambda_function_version
}

output "lambda_function_last_modified" {
  description = "The date Lambda Function resource was last modified"
  value       = module.lambda_function.lambda_function_last_modified
}

# IAM Role
output "lambda_role_arn" {
  description = "The ARN of the IAM role created for the Lambda Function"
  value       = module.lambda_function.lambda_role_arn
}

output "lambda_role_name" {
  description = "The name of the IAM role created for the Lambda Function"
  value       = module.lambda_function.lambda_role_name
}

# CloudWatch Log Group
output "lambda_cloudwatch_log_group_arn" {
  description = "The ARN of the Cloudwatch Log Group"
  value       = module.lambda_function.lambda_cloudwatch_log_group_arn
}

# # API Gateway
output "apigatewayv2_api_api_endpoint" {
  description = "The URI of the API"
  value       = module.api_gateway.apigatewayv2_api_api_endpoint
}

# API Gateway - Domain name
output "apigatewayv2_domain_name_id" {
  description = "The domain name identifier"
  value       = module.api_gateway.apigatewayv2_domain_name_id
}

output "apigatewayv2_domain_name_configuration" {
  description = "The domain name configuration"
  value       = module.api_gateway.apigatewayv2_domain_name_configuration
}

output "apigatewayv2_target_domain_name" {
  description = "The target domain name"
  value       = module.api_gateway.apigatewayv2_domain_name_target_domain_name
}

# output "apigatewayv2_hosted_zone_id" {
#   description = "The Amazon Route 53 Hosted Zone ID of the endpoint"
#   value       = module.api_gateway.apigatewayv2_domain_name_hosted_zone_id
# }

# Route53 record
# output "api_fqdn" {
#   description = "List of Route53 records"
#   value       = aws_route53_record.api.fqdn
# }

# output "api_endpoint" {
#   description = "FQDN of an API endpoint"
#   value       = "https://${aws_route53_record.api.fqdn}"
# }