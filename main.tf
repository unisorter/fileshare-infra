terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
    random = {
      source = "hashicorp/random"
    }
  }

  backend "remote" {
    organization = "unisorter"

    workspaces {
      name = "fileshare-infra"
    }
  }
}

module "s3" {
  source      = "./s3"
  bucket_name = "unisorter-file-share"
}

module "lambda_presign_upload_url" {
  source    = "./lambda"
  S3_BUCKET = "unisorter-file-share"
}

module "api_presign_upload_url" {
  source     = "./api-gateway"
  lambda_arn = module.lambda_presign_upload_url.arn
}
