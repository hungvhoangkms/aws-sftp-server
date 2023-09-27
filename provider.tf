terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  #   backend "s3" {
  #     bucket         = "bts-tfstate-hvh"
  #     key            = "dev/terraform.tfstate"
  #     dynamodb_table = "bts-state"

  #   }
}
# Configure the AWS Provider
provider "aws" {
}

