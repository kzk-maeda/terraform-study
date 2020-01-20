import sys
from awsglue.transforms import *
from awsglue.utils import getResolvedOptions
from pyspark.context import SparkContext
from awsglue.context import GlueContext
from awsglue.job import Job
from datetime import datetime, timedelta


## S3 Path
today = datetime.now().strftime("%Y-%m-%d")
class CreateS3Path:
    """
    S3出力パスを出力形式ごとに指定するクラス
    {bucket}/{target_name}/{json|csv|temp}/{yyyy-mm-dd}
    形式でのs3パスを返す
    """
    def __init__(self):
        self.s3_base_path = 's3://rds-rr-output-bucket01/outdata/'
        self.today = today

    def json(self, key):
        s3_json_path = self.s3_base_path + key + "/json/" + self.today
        return s3_json_path


## @params: [JOB_NAME]
args = getResolvedOptions(sys.argv, ['JOB_NAME'])

sc = SparkContext()
glueContext = GlueContext(sc)
spark = glueContext.spark_session
job = Job(glueContext)
job.init(args['JOB_NAME'], args)
## @type: DataSource
## @args: [database = "rds-database01", table_name = "world_city", transformation_ctx = "datasource0"]
## @return: datasource0
## @inputs: []
datasource0 = glueContext.create_dynamic_frame.from_catalog(database = "rds-database01", table_name = "world_city", transformation_ctx = "datasource0")
## @type: ApplyMapping
## @args: [mapping = [("population", "int", "population", "int"), ("id", "int", "id", "int"), ("countrycode", "string", "countrycode", "string"), ("district", "string", "district", "string"), ("name", "string", "name", "string")], transformation_ctx = "applymapping1"]
## @return: applymapping1
## @inputs: [frame = datasource0]
applymapping1 = ApplyMapping.apply(frame = datasource0, mappings = [("population", "int", "population", "int"), ("id", "int", "id", "int"), ("countrycode", "string", "countrycode", "string"), ("district", "string", "district", "string"), ("name", "string", "name", "string")], transformation_ctx = "applymapping1")
## @type: SelectFields
## @args: [paths = ["population", "id", "countrycode", "district", "name"], transformation_ctx = "selectfields2"]
## @return: selectfields2
## @inputs: [frame = applymapping1]
selectfields2 = SelectFields.apply(frame = applymapping1, paths = ["population", "id", "countrycode", "district", "name"], transformation_ctx = "selectfields2")
## @type: ResolveChoice
## @args: [choice = "MATCH_CATALOG", database = "rds-database01", table_name = "world_city", transformation_ctx = "resolvechoice3"]
## @return: resolvechoice3
## @inputs: [frame = selectfields2]
resolvechoice3 = ResolveChoice.apply(frame = selectfields2, choice = "MATCH_CATALOG", database = "rds-database01", table_name = "world_city", transformation_ctx = "resolvechoice3")
## @type: ResolveChoice
## @args: [choice = "make_cols", transformation_ctx = "resolvechoice4"]
## @return: resolvechoice4
## @inputs: [frame = resolvechoice3]
resolvechoice4 = ResolveChoice.apply(frame = resolvechoice3, choice = "make_cols", transformation_ctx = "resolvechoice4")
## @type: DataSink
## @args: [database = "rds-database01", table_name = "world_city", transformation_ctx = "datasink5"]
## @return: datasink5
## @inputs: [frame = resolvechoice4]
# datasink5 = glueContext.write_dynamic_frame.from_catalog(frame = resolvechoice4, database = "rds-database01", table_name = "world_city", transformation_ctx = "datasink5")
s3 = CreateS3Path()
uploadframe5 = resolvechoice4.toDF().repartition(1)
uploadframe5.write.mode('overwrite').json(s3.json("city_data"))

job.commit()