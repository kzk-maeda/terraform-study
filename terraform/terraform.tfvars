# Global Configuration
region="ap-northeast-1"

# Glue Configuration
rds_endpoint="mysql-rr01.cymocf1qckyr.ap-northeast-1.rds.amazonaws.com"
rds_database="world"
rds_username="admin"
rds_password="!Passw0rd"
rds_connection_name="rds-rr-connector001"
rds_availability_zone="ap-northeast-1a"
rds_security_group_id="sg-25b7295f"
rds_subnet_id="subnet-0f6f17c1951de6406"
glue_catalog_database="rds-database001"
glue_catalog_table="world_city001"
glue_crawler_name="rds-rr-crawler001"
glue_crawler_rds_path="world/city"