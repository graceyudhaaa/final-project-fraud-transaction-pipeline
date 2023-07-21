import os
import sys

from datetime import datetime, timedelta

import pyspark
from pyspark.sql import SparkSession
from pyspark.sql import functions as F
from pyspark.sql.types import StringType

spark = SparkSession \
        .builder.appName('PreprocessData') \
        .master("local[*]").config("spark.executor.memory", "2g")\
        .getOrCreate()


src_file = sys.argv[1]
output_filename = sys.argv[2]
src_path = f"/opt/airflow/datasets/{src_file}"

print("input file:", src_path)
print("output file:", output_filename)

print("######################################")
print("READING CSV FILE")
print("######################################")

df = spark.read \
    .option("header", True)\
    .csv(src_path)

dt = datetime(2023, 5, 1, 0)

def step_to_date(step, dt = dt):
    step = int(step)
    new_dt = dt + timedelta(hours=step)

    new_dt_str = new_dt.__str__()
    return new_dt_str

step_to_date_UDF = F.udf(lambda z: step_to_date(z),StringType())

print("######################################")
print("TRANSFORM STEP TO DATETIME")
print("######################################")

df_transform = df.withColumn('datetime',
                             F.to_timestamp(
                                 step_to_date_UDF(F.col('step'))
                            )
                )

print("######################################")
print("TRANSFORM DiffOrg")
print("######################################")

df_transform1 = df_transform.withColumn('DiffOrg',
                        F.when(
                            F.col('type') == 'CASH_IN',
                            F.round(F.col('newbalanceOrig') - F.col('oldbalanceOrg'), 2)
                        )\
                        .otherwise(
                            F.round(F.col('oldbalanceOrg') - F.col('newbalanceOrig'), 2)
                        )
                )

print("######################################")
print("TRANSFORM DiffOrgStatus")
print("######################################")

df_transform2 = df_transform1.withColumn('DiffOrgStatus',
                        F.when(
                            F.col('amount') == F.col('DiffOrg'),
                            1
                        )\
                        .otherwise(
                            0
                        )
                )


print("######################################")
print("DROP UNNECESSARY COLUMNS")
print("######################################")

df_transform3 = df_transform2.drop('nameDest', 'oldbalanceDest', 'newbalanceDest')


print("######################################")
print("SAVE DATA")
print("######################################")

df_transform3.repartition(1).write.parquet(f"/opt/airflow/datasets/{output_filename}")

# df_transform4 = df_transform3.toPandas().to_parquet(f"/opt/airflow/datasets/{output_filename}", engine="pyarrow" ,index=False)


