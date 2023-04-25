terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.26.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.0.1"
    }
  }
  required_version = ">= 1.1.0"

  cloud {
    organization = "prasheel-test-organization"

    workspaces {
      name = "gh-actions-demo"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "prasheel-test-bucket" {
  bucket_prefix = "my-tf-bucket-cloudfixlinter"
  tags = {
    Owner                       = "prasheel.tiwari@trilogy.com"
    "cloudfix:linter_yor_trace" = "97947a7b-2986-41b7-a6fb-a64ca78a4d07"
  }
}

resource "aws_ebs_volume" "data-vol" {
  availability_zone = "us-east-1a"
  size              = 1
  type              = "gp2"
  tags = {
    Owner                       = "prasheel.tiwari@trilogy.com"
    "cloudfix:linter_yor_trace" = "23075b98-f180-4c01-a86d-d91c8ef9e6e7"
  }
}