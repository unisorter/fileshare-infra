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

module "api_presigned_upload_url" {
  source    = "./api-gateway/http-presigned-upload-url"
  s3_bucket = "unisorter-file-share"
  name      = "presigned-upload-url"
}
