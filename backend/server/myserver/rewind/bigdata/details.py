from  pyspark.sql import SparkSession
from pyspark.sql.functions import col

spark = SparkSession.builder.getOrCreate()
spark.conf.set("spark.sql.catalog.casscatalog","com.datastax.spark.connector.datasource.CassandraCatalog")
data = spark.read.table("casscatalog.rewind.history").show()