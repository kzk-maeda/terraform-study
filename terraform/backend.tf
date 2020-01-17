terraform {
  required_version = ">= 0.11.0"
  backend "s3" {
    bucket  = "s3bucket-tst-study-tfstate-kzk-test" # 作成したS3バケット
    region  = "ap-northeast-1"
    key     = "terraform.tfstate"
    profile = "terraform-study02" # 利用するIAMのProfile
    encrypt = true
  }
}