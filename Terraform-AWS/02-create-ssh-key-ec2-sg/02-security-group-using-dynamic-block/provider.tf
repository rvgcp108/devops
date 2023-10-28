terraform {
  #  required_versoin = ">= 1.0"
  backend "local" {
    path = "./terraform.tfstate"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}


# Configure the AWS Provider
provider "aws" {
  region  = "us-west-2"
  profile = "cloud"
}

