provider "aws" {
  region     = "ap-northeast-1"
  version    = "~> 2.7"
}

data "aws_caller_identity" "self" { }