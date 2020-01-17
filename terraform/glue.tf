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

resource "aws_glue_catalog_database" "aws_glue_catalog_database" {
  name = "${var.glue_catalog_database}"
}

resource "aws_glue_catalog_table" "aws_glue_catalog_table" {
  name          = "${var.glue_catalog_table}"
  database_name = "${aws_glue_catalog_database.aws_glue_catalog_database.name}"
}

resource "aws_glue_crawler" "rds" {
  database_name = "${aws_glue_catalog_database.aws_glue_catalog_database.name}"
  name          = "${var.glue_crawler_name}"
  role          = "${aws_iam_role.glue-role.arn}"

  jdbc_target {
    connection_name = "${aws_glue_connection.rds.name}"
    path            = "${var.glue_crawler_rds_path}"
  }
}