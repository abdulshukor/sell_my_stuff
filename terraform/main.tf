provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "ab-tf-states"
    key    = "sell-my-stuff-frontend/terraform.tfstate"
    region = "us-east-1"

  }
}