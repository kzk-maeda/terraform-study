provider "aws" {
  region     = "${var.region}"
  profile    = "${var.profile}"
  version    = "~> 2.7"
}

data "aws_caller_identity" "self" { }