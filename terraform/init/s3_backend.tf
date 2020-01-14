provider "aws" {
  region     = "${var.region}"
  profile    = "${var.profile}"
  version    = "~> 2.7"
}

resource "aws_s3_bucket" "tfstate_bucket" {
  bucket        = "s3bucket-${var.env}-${var.s3_tfstate_bucket_name}-kzk-test"
  acl           = "private"
  versioning {
    enabled = true
  }
  force_destroy = true
}