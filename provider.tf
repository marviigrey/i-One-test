terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "5.85.0"
    }
  }
}
provider "aws" {
  region = "eu-west-2"
}