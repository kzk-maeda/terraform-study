# Configuration Glue Connector
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

# Configuration Glue Database and Table
resource "aws_glue_catalog_database" "aws_glue_catalog_database" {
  name = "${var.glue_catalog_database}"
}

resource "aws_glue_catalog_table" "aws_glue_catalog_table" {
  name          = "${var.glue_catalog_table}"
  database_name = "${aws_glue_catalog_database.aws_glue_catalog_database.name}"
}

# Configuration Glue Crawler
resource "aws_glue_crawler" "rds" {
  database_name = "${aws_glue_catalog_database.aws_glue_catalog_database.name}"
  name          = "${var.glue_crawler_name}"
  role          = "${aws_iam_role.glue-role.arn}"

  jdbc_target {
    connection_name = "${aws_glue_connection.rds.name}"
    path            = "${var.glue_crawler_rds_path}"
  }
}

# Upload Glue Job Code to S3
resource "aws_s3_bucket" "glue_job_bucket" {
  bucket = "${var.s3_bucket_glue_job}"
  acl    = "private"
}
resource "aws_s3_bucket_object" "glue_job" {
  bucket = "${var.s3_bucket_glue_job}"
  key    = "${var.s3_key_glue_job}"
  source = "${var.glue_job_source_file}"

  depends_on = [aws_s3_bucket.glue_job_bucket,]
}

# Configuration Glue Job
resource "aws_glue_job" "analyze_rds" {
  name     = "${var.glue_job_name}"
  role_arn = "${aws_iam_role.glue-role.arn}"

  command {
    script_location = "s3://${var.s3_bucket_glue_job}/${var.s3_key_glue_job}"
  }

  depends_on = [aws_s3_bucket_object.glue_job,]
}