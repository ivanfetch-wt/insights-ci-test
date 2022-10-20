variable "region" {
  default = "us-east-1"
}

variable "aws_profile" {
  default = ""
}

provider "aws" {
  region  = var.region
  profile = var.aws_profile
}

