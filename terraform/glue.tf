resource "aws_glue_connection" "rds" {
  connection_properties = {
    JDBC_CONNECTION_URL = "jdbc:mysql://${var.rds_endpoint}/${var.rds_database}"
    PASSWORD            = "${var.rds_password}"
    USERNAME            = "${var.rds_username}"
  }

  name = "${var.rds_connection_name}"

  physical_connection_requirements {
    availability_zone      = "${var.rds_availability_zone}"
    security_group_id_list = ["${var.rds_security_group_id}"]
    subnet_id              = "${var.rds_subnet_id}"
  }
}