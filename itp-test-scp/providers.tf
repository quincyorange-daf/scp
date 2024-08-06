terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
terraform {
  required_version = ">= 1.7.0, < 2.0.0"
}
# updated provider

provider "aws" {
  region = "ap-southeast-2"
}