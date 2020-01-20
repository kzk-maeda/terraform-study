# Main Configuration
variable "region" {}
variable "env" {
  description = "enter (tst|dev|prd)"
}
variable "profile" {}

# Glue Configuration
variable "rds_endpoint" {
  description = "description"
  default = "value"
}
variable "rds_database" {
  description = "description"
  default = "value"
}
variable "rds_username" {
  description = "description"
  default = "value"
}
variable "rds_password" {
  description = "description"
  default = "value"
}
variable "rds_connection_name" {
  description = "description"
  default = "value"
}
variable "rds_availability_zone" {
  description = "description"
  default = "value"
}
variable "rds_security_group_id" {
  description = "description"
  default = "value"
}
variable "rds_subnet_id" {
  description = "description"
  default = "value"
}
variable "glue_catalog_database" {
  description = "description"
  default = "value"
}
variable "glue_catalog_table" {
  description = "description"
  default = "value"
}
variable "glue_crawler_name" {
  description = "description"
  default = "value"
}
variable "glue_crawler_rds_path" {
  description = "description"
  default = "value"
}
variable "s3_bucket_glue_job" {
  description = "description"
  default = "value"
}
variable "s3_key_glue_job" {
  description = "description"
  default = "value"
}
variable "glue_job_source_file" {
  description = "description"
  default = "value"
}
variable "glue_job_name" {
  description = "description"
  default = "value"
}



