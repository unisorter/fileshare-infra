locals {
  bucket_name = var.bucket_name
}

# resource "aws_kms_key" "objects" {
#   description             = "KMS key is used to encrypt bucket objects"
#   deletion_window_in_days = 30
#   enable_key_rotation     = true
# }

module "log_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket                                = "${local.bucket_name}-logs"
  acl                                   = "log-delivery-write"
  force_destroy                         = true
  attach_deny_insecure_transport_policy = true

  # S3 bucket-level Public Access Block configuration
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

}

module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket        = local.bucket_name
  acl           = "private"
  force_destroy = true

  attach_deny_insecure_transport_policy = true

  versioning = {
    enabled = false
  }

  logging = {
    target_bucket = module.log_bucket.s3_bucket_id
    target_prefix = "log/"
  }

  lifecycle_rule = [
    {
      id      = "log"
      enabled = true
      prefix  = "log/"

      tags = {
        rule      = "log"
        autoclean = "true"
      }

      transition = [
        {
          days          = 30
          storage_class = "ONEZONE_IA"
          }, {
          days          = 60
          storage_class = "GLACIER"
        }
      ]

      expiration = {
        days = 90
      }

      noncurrent_version_expiration = {
        days = 30
      }

    }
  ]

  # server_side_encryption_configuration = {
  #   rule = {
  #     apply_server_side_encryption_by_default = {
  #       kms_master_key_id = aws_kms_key.objects.arn
  #       sse_algorithm     = "aws:kms"
  #     }
  #   }
  # }

  # S3 bucket-level Public Access Block configuration
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}