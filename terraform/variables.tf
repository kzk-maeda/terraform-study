# Main Configuration
variable "region" {}
variable "env" {
  description = "enter (tst|dev|prd)"
}
variable "profile" {}

# Glue Configuration
variable "rds_endpoint" {}
variable "rds_database" {}
variable "rds_username" {}
variable "rds_password" {}
variable "rds_connection_name" {}
variable "rds_availability_zone" {}
variable "rds_security_group_id" {}
variable "rds_subnet_id" {}


